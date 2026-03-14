import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:characters/characters.dart';
import '../../../../domain/entities/exam.dart';
import '../../../../domain/entities/reading_article.dart';
import '../../../../core/errors/exceptions.dart';

import '../../../../domain/entities/test_result.dart';

class ExamRemoteDataSource {
  final Dio _dio;
  final SupabaseClient _supabase;

  ExamRemoteDataSource({required Dio dio, required SupabaseClient supabase})
    : _dio = dio,
      _supabase = supabase;

  // In-memory cache
  List<Exam>? _examsCache;
  List<ReadingArticle>? _articlesCache;
  final Map<String, ReadingArticle> _articleDetailCache = {};
  final Map<String, Exam> _examDetailCache = {};
  List<TestResult>? _historyCache;

  void clearCache() {
    _examsCache = null;
    _articlesCache = null;
    _articleDetailCache.clear();
    _examDetailCache.clear();
    _historyCache = null;
  }

  Future<void> saveTestResult(TestResult result) async {
    try {
      debugPrint('DEBUG: Supabase INSERT TestResult: ${result.toJson()}');
      final response = await _supabase
          .from('TestResult')
          .insert(result.toJson());
      debugPrint('DEBUG: Supabase Insert Response: $response');
      _historyCache = null; // Invalidate cache
    } on PostgrestException catch (e) {
      debugPrint(
        'Supabase error saving test result: ${e.message} (code: ${e.code})',
      );
      debugPrint('DEBUG: Error Details: ${e.details}');
      debugPrint('DEBUG: Error Hint: ${e.hint}');
      throw ServerException(e.message, int.tryParse(e.code ?? '500') ?? 500);
    } catch (e) {
      debugPrint('Unexpected error saving test result: $e');
      throw ServerException(e.toString(), 500);
    }
  }

  Future<List<TestResult>> getTestHistory(String userId) async {
    try {
      if (_historyCache != null) return _historyCache!;

      final response = await _supabase
          .from('TestResult')
          .select()
          .eq('userId', userId)
          .order('completedAt', ascending: false);

      final List<dynamic> data = response;
      _historyCache = data.map((json) => TestResult.fromJson(json)).toList();
      return _historyCache!;
    } catch (e) {
      debugPrint('Error fetching test history: $e');
      return [];
    }
  }

  Future<List<Exam>> getExams() async {
    try {
      if (_examsCache != null && _examsCache!.isNotEmpty) {
        debugPrint('DEBUG: Serving exams from cache');
        return _examsCache!;
      }

      debugPrint('DEBUG: GET https://japalyze-web.vercel.app/api/tests');
      final response = await _dio.get(
        'https://japalyze-web.vercel.app/api/tests',
      );
      debugPrint('DEBUG: Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _examsCache = data.map((json) => Exam.fromJson(json)).toList();
        return _examsCache!;
      } else {
        throw ServerException(
          'Failed to load exams',
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred: ${e.toString()}',
        500,
      );
    }
  }

  Future<Exam> getExamDetail(String id) async {
    try {
      if (_examDetailCache.containsKey(id)) {
        debugPrint('DEBUG: Serving exam detail from cache: $id');
        return _examDetailCache[id]!;
      }

      debugPrint('DEBUG: GET https://japalyze-web.vercel.app/api/tests/$id');
      final response = await _dio.get(
        'https://japalyze-web.vercel.app/api/tests/$id',
      );
      debugPrint('DEBUG: Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final exam = Exam.fromJson(response.data);
        _examDetailCache[id] = exam;
        return exam;
      } else {
        throw ServerException(
          'Failed to load exam detail',
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      debugPrint(
        'DEBUG: DioException in getExamDetail: ${e.message}, data: ${e.response?.data}',
      );
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      debugPrint('DEBUG: Unknown error in getExamDetail: $e');
      throw ServerException(
        'An unexpected error occurred: ${e.toString()}',
        500,
      );
    }
  }

  Future<List<ReadingArticle>> getReadingArticles() async {
    try {
      if (_articlesCache != null && _articlesCache!.isNotEmpty) {
        debugPrint('DEBUG: Serving reading articles from cache');
        return _articlesCache!;
      }

      debugPrint('DEBUG: GET https://japalyze-web.vercel.app/api/reading');
      final response = await _dio.get(
        'https://japalyze-web.vercel.app/api/reading',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _articlesCache = data
            .map((json) => ReadingArticle.fromJson(json))
            .toList();
        return _articlesCache!;
      }

      // Fallback to Supabase if API fails
      final sbResponse = await _supabase
          .from('ReadingArticle')
          .select()
          .order('createdAt', ascending: false);

      _articlesCache = (sbResponse as List)
          .map((j) => ReadingArticle.fromJson(j))
          .toList();
      return _articlesCache!;
    } catch (e) {
      debugPrint('DEBUG: Error in getReadingArticles, trying fallback: $e');
      try {
        final response = await _supabase
            .from('ReadingArticle')
            .select()
            .order('createdAt', ascending: false);
        return (response as List)
            .map((j) => ReadingArticle.fromJson(j))
            .toList();
      } catch (_) {
        throw NetworkException('Failed to load reading articles');
      }
    }
  }

  Future<ReadingArticle> getReadingArticleDetail(String id) async {
    try {
      if (_articleDetailCache.containsKey(id)) {
        debugPrint('DEBUG: Serving reading article detail from cache: $id');
        return _articleDetailCache[id]!;
      }

      debugPrint('DEBUG: GET https://japalyze-web.vercel.app/api/reading/$id');
      final response = await _dio.get(
        'https://japalyze-web.vercel.app/api/reading/$id',
        options: Options(headers: {'x-mobile-app': 'true'}),
      );

      if (response.statusCode == 200) {
        final article = ReadingArticle.fromJson(response.data);
        _articleDetailCache[id] = article;
        return article;
      }

      final sbResponse = await _supabase
          .from('ReadingArticle')
          .select()
          .eq('id', id)
          .single();
      final article = ReadingArticle.fromJson(sbResponse);
      _articleDetailCache[id] = article;
      return article;
    } catch (e) {
      debugPrint('DEBUG: Error in getReadingArticleDetail: $e');
      final response = await _supabase
          .from('ReadingArticle')
          .select()
          .eq('id', id)
          .single();
      final article = ReadingArticle.fromJson(response);
      _articleDetailCache[id] = article;
      return article;
    }
  }

  Future<List<ReadingArticle>> getRandomReadingArticles() async {
    try {
      debugPrint(
        'DEBUG: GET https://japalyze-web.vercel.app/api/reading/random',
      );
      final response = await _dio.get(
        'https://japalyze-web.vercel.app/api/reading/random',
        options: Options(headers: {'x-mobile-app': 'true'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ReadingArticle.fromJson(json)).toList();
      }
      throw ServerException('Failed to load random articles', 500);
    } catch (e) {
      debugPrint('DEBUG: Error in getRandomReadingArticles: $e');
      // Fallback: get regular articles and shuffle locally
      return getReadingArticles();
    }
  }

  Future<Map<String, dynamic>> evaluateReadingSpeech({
    required String transcribedText,
    required String originalText,
    required int durationMs,
  }) async {
    try {
      debugPrint(
        'DEBUG: POST https://japalyze-web.vercel.app/api/reading/evaluate',
      );
      final response = await _dio.post(
        'https://japalyze-web.vercel.app/api/reading/evaluate',
        data: {
          'transcribedText': transcribedText,
          'originalText': originalText,
          'durationMs': durationMs,
        },
        options: Options(headers: {'x-mobile-app': 'true'}),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw ServerException(
        'Failed to evaluate speech',
        response.statusCode ?? 500,
      );
    } catch (e) {
      debugPrint('DEBUG: Error in evaluateReadingSpeech: $e');
      // Fallback: simple character matching if API fails
      return _localScoring(transcribedText, originalText);
    }
  }

  Map<String, dynamic> _localScoring(String spoken, String target) {
    final cleanTarget = target
        .replaceAll(RegExp(r'\[.*?\]'), '')
        .replaceAll(RegExp(r'[.,、。！？\s]'), '');
    final cleanSpoken = spoken.replaceAll(RegExp(r'[.,、。！？\s]'), '');

    if (cleanTarget.isEmpty) {
      return {'score': 0, 'feedback': 'Không có dữ liệu văn bản để chấm điểm.'};
    }

    int matches = 0;
    for (var char in cleanSpoken.characters) {
      if (cleanTarget.contains(char)) matches++;
    }

    double rawScore = (matches / cleanTarget.length) * 100;
    if (cleanSpoken.length < cleanTarget.length * 0.5) rawScore *= 0.6;

    final score = math.min(100, rawScore.round());

    return {
      'score': score,
      'feedback': score >= 80
          ? 'Tuyệt vời! Bạn phát âm rất chính xác.'
          : score >= 50
          ? 'Khá tốt, hãy rèn luyện thêm nhé.'
          : 'Cố gắng lên, hãy nghe mẫu và đọc lại.',
      'details': 'Chấm điểm cục bộ (Fallback)',
    };
  }
}

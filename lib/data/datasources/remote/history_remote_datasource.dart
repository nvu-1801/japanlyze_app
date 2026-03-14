import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../domain/entities/exercise_progress.dart';
import '../../../../domain/entities/test_result.dart';
import '../../../../core/errors/exceptions.dart';

abstract class HistoryRemoteDataSource {
  Future<List<ExerciseProgress>> getRecentExercises(
    String userId, {
    int limit = 5,
  });
  Future<List<TestResult>> getRecentTests(String userId, {int limit = 5});
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final SupabaseClient _supabase;

  HistoryRemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  // In-memory cache for recent activity
  final Map<String, List<ExerciseProgress>> _exercisesCache = {};
  final Map<String, List<TestResult>> _testsCache = {};

  void clearCache() {
    _exercisesCache.clear();
    _testsCache.clear();
  }

  @override
  Future<List<ExerciseProgress>> getRecentExercises(
    String userId, {
    int limit = 5,
  }) async {
    try {
      if (_exercisesCache.containsKey(userId)) {
        return _exercisesCache[userId]!;
      }

      final response = await _supabase
          .from('ExerciseProgress')
          .select()
          .eq('userId', userId)
          .order('completedAt', ascending: false)
          .limit(limit);

      final lessons = (response as List)
          .map((json) => ExerciseProgress.fromJson(json))
          .toList();

      _exercisesCache[userId] = lessons;
      return lessons;
    } on PostgrestException catch (e) {
      throw ServerException(
        e.message,
        e.code != null ? int.parse(e.code!) : 500,
      );
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<List<TestResult>> getRecentTests(
    String userId, {
    int limit = 5,
  }) async {
    try {
      if (_testsCache.containsKey(userId)) {
        return _testsCache[userId]!;
      }

      final response = await _supabase
          .from('TestResult')
          .select('*, MockTest(*)')
          .eq('userId', userId)
          .order('completedAt', ascending: false)
          .limit(limit);

      final tests = (response as List)
          .map((json) => TestResult.fromJson(json))
          .toList();

      _testsCache[userId] = tests;
      return tests;
    } on PostgrestException catch (e) {
      throw ServerException(
        e.message,
        e.code != null ? int.parse(e.code!) : 500,
      );
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }
}

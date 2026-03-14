import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../domain/entities/translation_history.dart';

abstract class TranslationRemoteDataSource {
  Future<List<TranslationHistory>> getTranslationHistory(String userId);
}

class TranslationRemoteDataSourceImpl implements TranslationRemoteDataSource {
  final SupabaseClient _supabase;

  TranslationRemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  // In-memory cache for translation history
  final Map<String, List<TranslationHistory>> _historyCache = {};

  void clearCache() => _historyCache.clear();

  @override
  Future<List<TranslationHistory>> getTranslationHistory(String userId) async {
    try {
      if (_historyCache.containsKey(userId)) {
        return _historyCache[userId]!;
      }

      final response = await _supabase
          .from('TranslationHistory')
          .select()
          .eq('userId', userId)
          .order('createdAt', ascending: false);

      final history = (response as List)
          .map((json) => TranslationHistory.fromJson(json))
          .toList();

      _historyCache[userId] = history;
      return history;
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

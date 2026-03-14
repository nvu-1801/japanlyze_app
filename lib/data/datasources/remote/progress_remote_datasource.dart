import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../domain/entities/user_progress.dart';

abstract class ProgressRemoteDataSource {
  Future<List<UserProgress>> getUserProgress(String userId);
  Future<void> saveUserProgress(UserProgress progress);
}

class ProgressRemoteDataSourceImpl implements ProgressRemoteDataSource {
  final SupabaseClient _supabase;

  ProgressRemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  // In-memory cache for user progress
  final Map<String, List<UserProgress>> _progressCache = {};

  void clearCache() => _progressCache.clear();

  @override
  Future<List<UserProgress>> getUserProgress(String userId) async {
    try {
      if (_progressCache.containsKey(userId)) {
        return _progressCache[userId]!;
      }

      final response = await _supabase
          .from('UserProgress')
          .select()
          .eq('userId', userId);

      final progress = (response as List)
          .map((json) => UserProgress.fromJson(json))
          .toList();

      _progressCache[userId] = progress;
      return progress;
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
  Future<void> saveUserProgress(UserProgress progress) async {
    try {
      await _supabase.from('UserProgress').upsert(progress.toJson());
      // Clear cache to ensure data is re-fetched when needed
      _progressCache.remove(progress.userId);
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

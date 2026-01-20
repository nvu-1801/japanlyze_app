import '../../../core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract interface for community (posts/comments) remote data operations
abstract class CommunityRemoteDataSource {
  Future<List<Map<String, dynamic>>> getPosts({int limit = 20, int offset = 0});
  Future<Map<String, dynamic>> createPost(String content, int rating, String userId);
  Future<List<Map<String, dynamic>>> getComments(String postId);
  Future<Map<String, dynamic>> createComment(String content, String postId, String userId);
  Future<void> likePost(String postId, String userId);
  Future<void> unlikePost(String postId, String userId);
}

/// Implementation of CommunityRemoteDataSource using Supabase
class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final SupabaseClient _supabase;

  CommunityRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<List<Map<String, dynamic>>> getPosts({int limit = 20, int offset = 0}) async {
    try {
      final response = await _supabase
          .from('Post')
          .select('*, User(id, name, avatar)')
          .order('createdAt', ascending: false)
          .range(offset, offset + limit - 1);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createPost(String content, int rating, String userId) async {
    try {
      final response = await _supabase.from('Post').insert({
        'content': content,
        'rating': rating,
        'userId': userId,
      }).select().single();

      return response;
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getComments(String postId) async {
    try {
      final response = await _supabase
          .from('Comment')
          .select('*, User(id, name, avatar)')
          .eq('postId', postId)
          .order('createdAt', ascending: true);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createComment(String content, String postId, String userId) async {
    try {
      final response = await _supabase.from('Comment').insert({
        'content': content,
        'postId': postId,
        'userId': userId,
      }).select().single();

      return response;
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    try {
      await _supabase.from('Like').insert({
        'postId': postId,
        'userId': userId,
      });
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> unlikePost(String postId, String userId) async {
    try {
      await _supabase
          .from('Like')
          .delete()
          .eq('postId', postId)
          .eq('userId', userId);
    } on PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }
}

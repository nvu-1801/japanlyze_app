import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/user.dart';

/// Abstract interface for auth remote data operations
abstract class AuthRemoteDataSource {
  Future<(User, String)> login(String email, String password);
  Future<(User, String)> register(String name, String email, String password);
  Future<User> getCurrentUser();
  Future<void> logout();
}

/// Implementation of AuthRemoteDataSource using Supabase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final supabase.SupabaseClient _supabase;

  AuthRemoteDataSourceImpl({required supabase.SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<(User, String)> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException('Failed to sign in');
      }

      // Fetch user details from users table
      final userData = await _supabase
          .from('User')
          .select()
          .eq('id', response.user!.id)
          .single();

      final user = User.fromJson(userData);
      final token = response.session?.accessToken ?? '';
      return (user, token);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } on supabase.PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<(User, String)> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      // Sign up with Supabase Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw const AuthException('Failed to create account');
      }

      // Insert user into users table
      final userData = await _supabase.from('User').insert({
        'id': response.user!.id,
        'email': email,
        'name': name,
        'provider': 'email',
        'role': 'user',
        'isPremium': false,
      }).select().single();

      final user = User.fromJson(userData);
      final token = response.session?.accessToken ?? '';
      return (user, token);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } on supabase.PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null) {
        throw const AuthException('No authenticated user');
      }

      // Fetch user details from users table
      final userData = await _supabase
          .from('User')
          .select()
          .eq('id', currentUser.id)
          .single();

      return User.fromJson(userData);
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } on supabase.PostgrestException catch (e) {
      throw ServerException(e.message, e.code != null ? int.parse(e.code!) : 500);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } on supabase.AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }
}

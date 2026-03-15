import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:bcrypt/bcrypt.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/user.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

/// Abstract interface for auth remote data operations
abstract class AuthRemoteDataSource {
  Future<(User, String)> login(String email, String password);
  Future<(User, String)> register(String name, String email, String password);
  Future<User> getCurrentUser(String userId);
  Future<void> logout();
  Future<User> updateProfile(User user);
  Future<(User, String)> signInWithGoogle();
}

/// Implementation of AuthRemoteDataSource using Supabase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final supabase.SupabaseClient _supabase;

  AuthRemoteDataSourceImpl({required supabase.SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<(User, String)> login(String email, String password) async {
    try {
      print('Manual Login attempt for: $email');

      // 1. Fetch user by email directly from the 'User' table
      final userData = await _supabase
          .from('User')
          .select()
          .eq('email', email)
          .limit(1)
          .maybeSingle();

      if (userData == null) {
        print('Manual Login: User not found for email: $email');
        throw const AuthException('Tài khoản không tồn tại trong hệ thống.');
      }

      // 2. Verify password using Bcrypt
      final String? hashedPassword = userData['password'];
      if (hashedPassword == null) {
        print(
          'Manual Login: User found but has no password (Google login user?).',
        );
        throw const AuthException(
          'Tài khoản này không có mật khẩu. Hãy thử đăng nhập bằng Google.',
        );
      }

      print('Manual Login: Verifying password...');
      final bool isMatch = BCrypt.checkpw(password, hashedPassword);

      if (!isMatch) {
        print('Manual Login: Password mismatch.');
        throw const AuthException('Mật khẩu không chính xác.');
      }

      // 3. Success - Create User object
      final user = User.fromJson(userData);

      // We use the User ID as the token since we're not using Supabase Auth JWTs
      final token = user.uuid;

      print('Manual Login: SUCCESS for user ${user.uuid}');
      return (user, token);
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      print('Manual Login Error: $e');
      if (e is supabase.PostgrestException) {
        throw ServerException('Lỗi cơ sở dữ liệu: ${e.message}', 500);
      }
      throw NetworkException('Lỗi hệ thống: ${e.toString()}');
    }
  }

  @override
  Future<(User, String)> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      print('Manual Register attempt for: $email');

      // 1. Check if user already exists
      final existingUser = await _supabase
          .from('User')
          .select('id')
          .eq('email', email)
          .limit(1)
          .maybeSingle();

      if (existingUser != null) {
        throw const AuthException('Email này đã được đăng ký.');
      }

      // 2. Hash password
      final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      // 3. Create new user record
      final userId = uuid.v4();
      final userData = await _supabase
          .from('User')
          .insert({
            'id': userId,
            'email': email,
            'password': hashedPassword,
            'name': name,
            'role': 'user',
            'provider': 'email',
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
          })
          .select()
          .limit(1)
          .single();

      final user = User.fromJson(userData);
      final token = user.uuid;

      print('Manual Register: SUCCESS for user ${user.uuid}');
      return (user, token);
    } on AuthException {
      rethrow;
    } catch (e) {
      print('Manual Register Error: $e');
      throw NetworkException('Lỗi đăng ký: ${e.toString()}');
    }
  }

  @override
  Future<User> getCurrentUser(String userId) async {
    try {
      final userData = await _supabase
          .from('User')
          .select()
          .eq('id', userId)
          .limit(1)
          .maybeSingle();

      if (userData == null) {
        throw const AuthException('User record not found');
      }

      return User.fromJson(userData);
    } catch (e) {
      print('Manual getCurrentUser Error: $e');
      throw NetworkException('Lỗi đồng bộ thông tin: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    // No-op for server-side in pure DB mode since there's no session to invalidate
    print('Manual Logout: Session cleared locally.');
    return;
  }

  @override
  Future<User> updateProfile(User user) async {
    try {
      final userData = await _supabase
          .from('User')
          .update(user.toJson())
          .eq('id', user.uuid)
          .select()
          .limit(1)
          .maybeSingle();

      if (userData == null) {
        throw const AuthException('Lỗi khi cập nhật thông tin người dùng.');
      }

      return User.fromJson(userData);
    } catch (e) {
      throw NetworkException('Lỗi cập nhật hồ sơ: ${e.toString()}');
    }
  }

  @override
  Future<(User, String)> signInWithGoogle() async {
    try {
      print('Manual Google Login Start');

      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException('Google Sign In was cancelled');
      }

      print(
        'Manual Google Login: Success from Google. Email: ${googleUser.email}',
      );

      // 1. Check if user exists in our DB
      var userData = await _supabase
          .from('User')
          .select()
          .eq('email', googleUser.email)
          .limit(1)
          .maybeSingle();

      if (userData == null) {
        print('Manual Google Login: New user, creating record...');
        // 2. Create new user
        userData = await _supabase
            .from('User')
            .insert({
              'id': uuid.v4(),
              'email': googleUser.email,
              'name': googleUser.displayName ?? 'User',
              'avatar': googleUser.photoUrl,
              'provider': 'google',
              'role': 'user',
              'createdAt': DateTime.now().toIso8601String(),
              'updatedAt': DateTime.now().toIso8601String(),
            })
            .select()
            .limit(1)
            .single();
      } else {
        print('Manual Google Login: Existing user, syncing profile...');
        // 3. Update existing user (optional sync)
        userData = await _supabase
            .from('User')
            .update({
              'name': userData['name'] ?? googleUser.displayName,
              'avatar': userData['avatar'] ?? googleUser.photoUrl,
              'updatedAt': DateTime.now().toIso8601String(),
            })
            .eq('email', googleUser.email)
            .select()
            .limit(1)
            .single();
      }

      final user = User.fromJson(userData);
      final token = user.uuid;

      return (user, token);
    } on AuthException {
      rethrow;
    } catch (e) {
      print('Manual Google Login Error: $e');
      throw NetworkException('Lỗi Google Login: ${e.toString()}');
    }
  }
}

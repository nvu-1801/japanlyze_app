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
  Future<User> getCurrentUser();
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
      print('Supabase Login attempt for: $email');
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        print('Supabase Login: User is null');
        throw const AuthException('Failed to sign in');
      }

      print(
        'Supabase Login: Auth success, fetching user data for ID: ${response.user!.id}',
      );

      // Fetch user details from users table
      final userData = await _supabase
          .from('User')
          .select()
          .eq('id', response.user!.id)
          .single();

      print('Supabase Login: User data fetched: $userData');

      final user = User.fromJson(userData);
      final token = response.session?.accessToken ?? '';
      return (user, token);
    } on supabase.AuthException catch (e) {
      print('Supabase AuthException: ${e.message}');
      // Check for legacy migration if it's an invalid credentials error
      if (e.message.toLowerCase().contains('invalid login credentials') ||
          e.message.toLowerCase().contains('invalid claim')) {
        return _handleLegacyMigration(email, password);
      }
      throw AuthException(e.message);
    } on supabase.PostgrestException catch (e) {
      print('Supabase PostgrestException: ${e.message} (code: ${e.code})');
      throw ServerException(
        e.message,
        e.code != null ? int.tryParse(e.code!) ?? 500 : 500,
      );
    } catch (e) {
      print('Supabase Global Exception: $e');
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
      print('Supabase Register attempt for: $email');
      // Sign up with Supabase Auth
      // The name is passed in userMetadata so the trigger can pick it up
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw const AuthException('Failed to create account');
      }

      print('Supabase Register: Auth success, checking session...');

      // If session is null, it means email confirmation is likely required
      if (response.session == null) {
        print(
          'Supabase Register: Session is null, email confirmation required',
        );
        throw const AuthException(
          'Account created! Please check your email to confirm your account before logging in.',
        );
      }

      print('Supabase Register: Session found, waiting for trigger sync...');

      // Wait a brief moment for the trigger to execute
      await Future.delayed(const Duration(seconds: 2));

      // Try to fetch the user profile with a simple retry mechanism
      Map<String, dynamic>? userData;
      int attempts = 0;
      while (attempts < 3) {
        try {
          userData = await _supabase
              .from('User')
              .select()
              .eq('id', response.user!.id)
              .single();
          break;
        } catch (e) {
          attempts++;
          if (attempts >= 3) {
            print('Supabase Register: Sync failed after 3 attempts: $e');
            throw const AuthException(
              'Account created but profile sync failed. Please check if SQL Trigger and RLS policies are applied.',
            );
          }
          print('Supabase Register: Syncing... attempt $attempts');
          await Future.delayed(const Duration(seconds: 2));
        }
      }

      final user = User.fromJson(userData!);
      final token = response.session?.accessToken ?? '';
      return (user, token);
    } on supabase.AuthException catch (e) {
      print('Supabase Register AuthException: ${e.message}');
      if (e.message.toLowerCase().contains('user already registered')) {
        throw const AuthException(
          'Email này đã được đăng ký trên Web. Vui lòng sử dụng chức năng Đăng nhập để tự động đồng bộ tài khoản.',
        );
      }
      throw AuthException(e.message);
    } on supabase.PostgrestException catch (e) {
      print('Supabase Register PostgrestException: ${e.message}');
      throw ServerException(
        e.message,
        e.code != null ? int.tryParse(e.code!) ?? 500 : 500,
      );
    } catch (e) {
      print('Supabase Register Global Error: $e');
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
      throw ServerException(
        e.message,
        e.code != null ? int.parse(e.code!) : 500,
      );
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

  @override
  Future<User> updateProfile(User user) async {
    try {
      final userData = await _supabase
          .from('User')
          .update(user.toJson())
          .eq('id', user.uuid)
          .select()
          .single();

      return User.fromJson(userData);
    } on supabase.PostgrestException catch (e) {
      throw ServerException(
        e.message,
        e.code != null ? int.tryParse(e.code!) ?? 500 : 500,
      );
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<(User, String)> signInWithGoogle() async {
    try {
      // 1. Initialize Google Sign In
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException('Google Sign In was cancelled');
      }

      // 2. Get authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw const AuthException('Failed to get ID Token from Google');
      }

      // 3. MANUAL DATABASE SYNC (Bypassing Supabase Auth)
      // Mirroring the Web behavior: Only interact with the 'User' table

      // Check if user exists
      final existingUserResponse = await _supabase
          .from('User')
          .select()
          .eq('email', googleUser.email)
          .maybeSingle();

      Map<String, dynamic> userData;

      if (existingUserResponse != null) {
        print('Manual Google Login: Existing user found, updating profile...');
        // Update user (sync name/avatar from Google)
        userData = await _supabase
            .from('User')
            .update({
              'name': googleUser.displayName ?? existingUserResponse['name'],
              'avatar': googleUser.photoUrl ?? existingUserResponse['avatar'],
              'updatedAt': DateTime.now().toIso8601String(),
            })
            .eq('email', googleUser.email)
            .select()
            .single();
      } else {
        print('Manual Google Login: New user, creating record...');
        // Create new user
        userData = await _supabase
            .from('User')
            .insert({
              'id': uuid
                  .v4(), // Generate a new UUID if not using Supabase Auth ID
              'email': googleUser.email,
              'name': googleUser.displayName ?? 'User',
              'avatar': googleUser.photoUrl,
              'provider': 'google',
              'role': 'user',
              'createdAt': DateTime.now().toIso8601String(),
              'updatedAt': DateTime.now().toIso8601String(),
            })
            .select()
            .single();
      }

      final user = User.fromJson(userData);
      // For manual login, we use the idToken as a temporary session identifier
      // since we aren't creating a real Supabase Auth session.
      return (user, idToken);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw NetworkException('Google Sign In error: ${e.toString()}');
    }
  }

  /// Handles migration for users who registered on the Web (Next.js/Prisma)
  /// but haven't used Supabase Auth yet.
  Future<(User, String)> _handleLegacyMigration(
    String email,
    String password,
  ) async {
    try {
      print('Migration: Checking for legacy web account for $email');
      // 1. Try to find the user in the public.User table
      // Note: This assumes RLS allows anonymous selection for this specific purpose
      // or that we are relying on the user's explicit intent to migrate.
      final legacyData = await _supabase
          .from('User')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (legacyData != null && legacyData['password'] != null) {
        final String hashedPassword = legacyData['password'];

        // 2. Verify Bcrypt hash from legacy DB
        if (BCrypt.checkpw(password, hashedPassword)) {
          print(
            'Migration: Legacy password verified. Creating Auth account...',
          );

          // 3. Create Supabase Auth account
          // This will trigger the PostgreSQL trigger to link the User table
          final signUpResponse = await _supabase.auth.signUp(
            email: email,
            password: password,
            data: {'name': legacyData['name'] ?? 'User'},
          );

          if (signUpResponse.user != null) {
            if (signUpResponse.session != null) {
              print('Migration: Auth account created. Retrying login...');
              // Re-run standard login to get full profile and token
              return login(email, password);
            } else {
              // Probably needs email confirmation
              throw const AuthException(
                'Tài khoản Web của bạn đã được nhận diện. Vui lòng kiểm tra email để xác nhận tài khoản trước khi đăng nhập trên Mobile.',
              );
            }
          }
        }
      }
    } catch (e) {
      print('Migration Error: $e');
      if (e is AuthException) rethrow;
    }

    throw const AuthException('Thông tin đăng nhập không chính xác.');
  }
}

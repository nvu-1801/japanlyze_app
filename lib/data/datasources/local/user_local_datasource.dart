import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/user.dart';

/// Abstract interface for user local data operations
abstract class UserLocalDataSource {
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();
  Future<void> clearUser();
  Future<String?> getToken();
  Future<void> cacheToken(String token);
  Future<void> clearToken();
  Future<bool> isLoggedIn();
  Future<void> clearAll();
}

/// Implementation of UserLocalDataSource
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  UserLocalDataSourceImpl({
    required FlutterSecureStorage secureStorage,
    required SharedPreferences sharedPreferences,
  }) : _secureStorage = secureStorage,
       _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheUser(User user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await _sharedPreferences.setString(AppConstants.userKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache user: $e');
    }
  }

  @override
  Future<User?> getCachedUser() async {
    try {
      final jsonString = _sharedPreferences.getString(AppConstants.userKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return User.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      await clearUser();
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    await _sharedPreferences.remove(AppConstants.userKey);
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.tokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    try {
      await _secureStorage.write(key: AppConstants.tokenKey, value: token);
    } catch (e) {
      throw CacheException('Failed to cache token: $e');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _secureStorage.delete(key: AppConstants.tokenKey);
    } catch (e) {
      // Ignore errors when clearing
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearAll() async {
    await Future.wait([clearUser(), clearToken()]);
  }
}

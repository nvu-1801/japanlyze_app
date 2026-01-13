import 'package:dio/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/user.dart';

/// Abstract interface for auth remote data operations
abstract class AuthRemoteDataSource {
  Future<(User, String)> login(String email, String password);
  Future<(User, String)> register(String name, String email, String password);
  Future<User> getCurrentUser();
  Future<void> logout();
}

/// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<(User, String)> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final data = response.data;
      final user = User.fromJson(data['user']);
      final token = data['token'] as String? ?? '';
      return (user, token);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<(User, String)> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      final data = response.data;
      final user = User.fromJson(data['user']);
      final token = data['token'] as String? ?? '';
      return (user, token);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return User.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode ?? 500;
      final message = e.response!.data?['message'] ?? 'Server error';

      if (statusCode == 401) {
        return AuthException(message);
      }
      return ServerException(message, statusCode);
    }
    return const NetworkException('Network error occurred');
  }
}

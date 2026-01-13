/// Custom exceptions for the app
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException([this.message = 'Server error', this.statusCode]);

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException([this.message = 'Cache error']);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException([this.message = 'Network error']);

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;

  const AuthException([this.message = 'Authentication error']);

  @override
  String toString() => 'AuthException: $message';
}

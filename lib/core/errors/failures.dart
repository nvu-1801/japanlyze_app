import 'package:equatable/equatable.dart';

/// Base Failure class for error handling
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure(this.message, [this.code]);

  @override
  List<Object?> get props => [message, code];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred', int? code])
    : super(message, code);

  factory ServerFailure.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return const ServerFailure('Bad request', 400);
      case 401:
        return const ServerFailure('Unauthorized', 401);
      case 403:
        return const ServerFailure('Forbidden', 403);
      case 404:
        return const ServerFailure('Not found', 404);
      case 500:
        return const ServerFailure('Internal server error', 500);
      default:
        return ServerFailure('Server error: $statusCode', statusCode);
    }
  }
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'No internet connection'])
    : super(message);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
    : super(message);
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication failed'])
    : super(message);

  static const AuthFailure invalidCredentials = AuthFailure(
    'Invalid email or password',
  );
  static const AuthFailure sessionExpired = AuthFailure(
    'Session expired. Please login again',
  );
  static const AuthFailure emailAlreadyExists = AuthFailure(
    'Email already registered',
  );
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);

  static const ValidationFailure invalidEmail = ValidationFailure(
    'Invalid email format',
  );
  static const ValidationFailure weakPassword = ValidationFailure(
    'Password must be at least 8 characters',
  );
  static const ValidationFailure emptyField = ValidationFailure(
    'This field cannot be empty',
  );
}

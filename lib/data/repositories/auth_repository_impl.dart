import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

/// Implementation of AuthRepository with offline support
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final Connectivity _connectivity;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
    required Connectivity connectivity,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _connectivity = connectivity;

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (!await _isConnected()) {
      return const Left(NetworkFailure());
    }

    try {
      final (user, token) = await _remoteDataSource.login(email, password);
      await _localDataSource.cacheToken(token);
      await _localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String name,
    String email,
    String password,
  ) async {
    if (!await _isConnected()) {
      return const Left(NetworkFailure());
    }

    try {
      final (user, token) = await _remoteDataSource.register(
        name,
        email,
        password,
      );
      await _localDataSource.cacheToken(token);
      await _localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    // First, try to get cached user
    try {
      final cachedUser = await _localDataSource.getCachedUser();

      if (await _isConnected()) {
        // If connected, try to get fresh data
        try {
          final user = await _remoteDataSource.getCurrentUser();
          await _localDataSource.cacheUser(user);
          return Right(user);
        } on AuthException {
          // Token expired, clear local data
          await _localDataSource.clearAll();
          return const Left(AuthFailure.sessionExpired);
        } catch (e) {
          // If remote fails but we have cached data, return it
          if (cachedUser != null) {
            return Right(cachedUser);
          }
          return Left(ServerFailure(e.toString()));
        }
      } else {
        // Offline - return cached user if available
        if (cachedUser != null) {
          return Right(cachedUser);
        }
        return const Left(
          NetworkFailure('No internet connection and no cached user'),
        );
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to logout on server if connected
      if (await _isConnected()) {
        try {
          await _remoteDataSource.logout();
        } catch (_) {
          // Ignore remote errors, continue with local logout
        }
      }
      // Always clear local data
      await _localDataSource.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    // TODO: Implement refresh token when backend supports it
    return const Left(ServerFailure('Refresh token not implemented'));
  }

  Future<bool> _isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

/// Base UseCase interface
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use when no parameters needed
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}

/// Stream-based UseCase for real-time data
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

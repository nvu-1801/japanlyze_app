import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/deck.dart';
import '../../repositories/flashcard_repository.dart';

/// Use case for creating a new deck
class CreateDeckUseCase implements UseCase<Deck, CreateDeckParams> {
  final FlashcardRepository _repository;

  CreateDeckUseCase(this._repository);

  @override
  Future<Either<Failure, Deck>> call(CreateDeckParams params) async {
    return _repository.createDeck(params.title, params.description);
  }
}

class CreateDeckParams extends Equatable {
  final String title;
  final String? description;

  const CreateDeckParams({required this.title, this.description});

  @override
  List<Object?> get props => [title, description];
}

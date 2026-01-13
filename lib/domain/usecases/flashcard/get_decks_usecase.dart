import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/deck.dart';
import '../../repositories/flashcard_repository.dart';

/// Use case for getting all flashcard decks
class GetDecksUseCase implements UseCase<List<Deck>, NoParams> {
  final FlashcardRepository _repository;

  GetDecksUseCase(this._repository);

  @override
  Future<Either<Failure, List<Deck>>> call(NoParams params) async {
    return _repository.getDecks();
  }
}

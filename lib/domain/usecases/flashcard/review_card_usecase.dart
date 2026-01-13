import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/card.dart';
import '../../repositories/flashcard_repository.dart';

/// Use case for reviewing a flashcard with SRS
class ReviewCardUseCase implements UseCase<Card, ReviewCardParams> {
  final FlashcardRepository _repository;

  ReviewCardUseCase(this._repository);

  @override
  Future<Either<Failure, Card>> call(ReviewCardParams params) async {
    return _repository.reviewCard(
      cardId: params.cardId,
      quality: params.quality,
    );
  }
}

/// Parameters for reviewing a card
/// Quality is based on SM-2 algorithm:
/// - 0: Complete blackout
/// - 1: Incorrect; correct answer remembered on seeing it
/// - 2: Incorrect; correct answer seemed easy to recall
/// - 3: Correct response recalled with serious difficulty
/// - 4: Correct response after a hesitation
/// - 5: Perfect response
class ReviewCardParams extends Equatable {
  final int cardId;
  final int quality;

  const ReviewCardParams({required this.cardId, required this.quality})
    : assert(quality >= 0 && quality <= 5, 'Quality must be between 0 and 5');

  @override
  List<Object> get props => [cardId, quality];
}

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/deck.dart';
import '../entities/card.dart';

/// Repository interface for flashcard operations
abstract class FlashcardRepository {
  /// Get all decks for current user
  Future<Either<Failure, List<Deck>>> getDecks();

  /// Get a specific deck by ID
  Future<Either<Failure, Deck>> getDeckById(int id);

  /// Create a new deck
  Future<Either<Failure, Deck>> createDeck(String title, String? description);

  /// Update a deck
  Future<Either<Failure, Deck>> updateDeck(
    int id,
    String title,
    String? description,
  );

  /// Delete a deck
  Future<Either<Failure, void>> deleteDeck(int id);

  /// Get all cards in a deck
  Future<Either<Failure, List<Card>>> getCards(int deckId);

  /// Get due cards for review
  Future<Either<Failure, List<Card>>> getDueCards(int deckId);

  /// Create a new card
  Future<Either<Failure, Card>> createCard({
    required int deckId,
    required String front,
    required String back,
    String? example,
  });

  /// Update a card
  Future<Either<Failure, Card>> updateCard(Card card);

  /// Delete a card
  Future<Either<Failure, void>> deleteCard(int cardId);

  /// Review a card with SRS algorithm
  Future<Either<Failure, Card>> reviewCard({
    required int cardId,
    required int quality, // 0-5 rating
  });
}

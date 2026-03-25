import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/flashcard_models.dart';
import '../../domain/entities/conversation_models.dart';

/// Repository for managing flashcard data with offline-first architecture
class FlashcardRepository {
  final Isar _isar;
  final Uuid _uuid = const Uuid();

  FlashcardRepository(this._isar);

  /// Get or create a flashcard deck for a quest
  Future<FlashcardDeck> getOrCreateDeck({
    required String questId,
    required String title,
    String? description,
  }) async {
    final existingDeck = await _isar.flashcardDecks
        .filter()
        .questIdEqualTo(questId)
        .findFirst();

    if (existingDeck != null) {
      return existingDeck;
    }

    final newDeck = FlashcardDeck.create(
      deckId: _uuid.v4(),
      questId: questId,
      title: title,
      description: description,
    );

    await _isar.writeTxn(() async {
      await _isar.flashcardDecks.put(newDeck);
    });

    return newDeck;
  }

  /// Create flashcards from vocabulary items
  Future<void> createFlashcardsFromVocab({
    required String questId,
    required List<VocabItem> vocabItems,
  }) async {
    final deck = await getOrCreateDeck(
      questId: questId,
      title: 'Flashcards for $questId',
    );

    final cards = <FlashcardItem>[];

    for (var i = 0; i < vocabItems.length; i++) {
      final vocab = vocabItems[i];
      final cardId = '${questId}_card_$i';

      // Check if card with this cardId already exists
      final existing = await _isar.flashcardItems
          .filter()
          .cardIdEqualTo(cardId)
          .findFirst();

      if (existing != null) continue;

      final card = FlashcardItem.create(
        cardId: cardId,
        questId: questId,
        japanese: vocab.kanji.isNotEmpty ? vocab.kanji : vocab.kana,
        kana: vocab.kana,
        romaji: vocab.romaji,
        meaning: vocab.meaning,
        note: vocab.note,
      );
      cards.add(card);
    }

    if (cards.isNotEmpty) {
      debugPrint('SRS: Creating ${cards.length} NEW cards for quest: $questId');
      await _isar.writeTxn(() async {
        await _isar.flashcardItems.putAll(cards);
      });
    }

    await _isar.writeTxn(() async {
      // Update deck stats
      deck.totalCards = cards.length;
      deck.masteredCards = 0;
      deck.dueCards = cards.length;
      deck.progress = 0.0;
      deck.isCompleted = false;
      deck.updatedAt = DateTime.now();
      await _isar.flashcardDecks.put(deck);
    });
  }

  /// Get all flashcards for a quest
  Future<List<FlashcardItem>> getFlashcardsForQuest(String questId) async {
    return await _isar.flashcardItems
        .filter()
        .questIdEqualTo(questId)
        .sortByCreatedAt()
        .findAll();
  }

  /// Get flashcards due for review
  Future<List<FlashcardItem>> getDueFlashcards(String questId) async {
    final now = DateTime.now();
    return await _isar.flashcardItems
        .filter()
        .questIdEqualTo(questId)
        .nextReviewDateLessThan(now.add(const Duration(days: 1)))
        .sortByNextReviewDate()
        .findAll();
  }

  /// Get flashcard deck for a quest
  Future<FlashcardDeck?> getDeck(String questId) async {
    return await _isar.flashcardDecks
        .filter()
        .questIdEqualTo(questId)
        .findFirst();
  }

  /// Update flashcard after review
  Future<void> updateFlashcardReview({
    required String cardId,
    required FlashcardRating rating,
  }) async {
    await _isar.writeTxn(() async {
      final cards = await _isar.flashcardItems
          .filter()
          .cardIdEqualTo(cardId)
          .findAll();

      if (cards.isNotEmpty) {
        // Preference: pick the one that already has a rating index
        final card = cards.length > 1
            ? (cards.where((c) => c.lastRatingIndex != null).firstOrNull ??
                  cards.first)
            : cards.first;

        debugPrint('SRS: Updating card $cardId with rating ${rating.name}');
        card.updateSRS(rating);
        await _isar.flashcardItems.put(card);

        // Optional: Clean up other duplicates if they exist
        if (cards.length > 1) {
          final toDelete = cards
              .where((c) => c.id != card.id)
              .map((c) => c.id)
              .toList();
          await _isar.flashcardItems.deleteAll(toDelete);
          debugPrint(
            'SRS: Cleaned up ${toDelete.length} duplicate cards for $cardId',
          );
        }

        // Update deck stats
        final deck = await _isar.flashcardDecks
            .filter()
            .questIdEqualTo(card.questId)
            .findFirst();

        if (deck != null) {
          final allCards = await getFlashcardsForQuest(card.questId);
          deck.updateStats(allCards);
          await _isar.flashcardDecks.put(deck);
        }
      } else {
        debugPrint('SRS ERROR: Card NOT FOUND for ID: $cardId');
      }
    });
  }

  /// Get deck progress
  Future<double> getDeckProgress(String questId) async {
    final deck = await getDeck(questId);
    return deck?.progress ?? 0.0;
  }

  /// Check if deck is completed
  Future<bool> isDeckCompleted(String questId) async {
    final deck = await getDeck(questId);
    return deck?.isCompleted ?? false;
  }

  /// Reset flashcard progress for a quest
  Future<void> resetFlashcards(String questId) async {
    await _isar.writeTxn(() async {
      final cards = await getFlashcardsForQuest(questId);

      for (final card in cards) {
        card.srsLevel = SRSLevel.newCard;
        card.easeFactor = 2.5;
        card.interval = 0;
        card.repetitions = 0;
        card.nextReviewDate = DateTime.now();
        card.correctCount = 0;
        card.incorrectCount = 0;
        card.isMastered = false;
        card.updatedAt = DateTime.now();
      }

      await _isar.flashcardItems.putAll(cards);

      // Reset deck
      final deck = await getDeck(questId);
      if (deck != null) {
        deck.totalCards = cards.length;
        deck.masteredCards = 0;
        deck.dueCards = cards.length;
        deck.progress = 0.0;
        deck.isCompleted = false;
        deck.updatedAt = DateTime.now();
        await _isar.flashcardDecks.put(deck);
      }
    });
  }

  /// Save progress history
  Future<void> saveProgressHistory(UserProgressHistory history) async {
    await _isar.writeTxn(() async {
      await _isar.userProgressHistorys.put(history);
    });
  }

  /// Get progress history for a quest
  Future<List<UserProgressHistory>> getProgressHistory(String questId) async {
    return await _isar.userProgressHistorys
        .filter()
        .questIdEqualTo(questId)
        .sortByStartedAtDesc()
        .findAll();
  }

  /// Get all due flashcards across all quests
  Future<List<FlashcardItem>> getAllDueFlashcards() async {
    final now = DateTime.now();
    return await _isar.flashcardItems
        .filter()
        .nextReviewDateLessThan(now.add(const Duration(days: 1)))
        .sortByNextReviewDate()
        .findAll();
  }

  /// Get statistics for a quest
  Future<Map<String, dynamic>> getQuestStats(String questId) async {
    final cards = await getFlashcardsForQuest(questId);
    final deck = await getDeck(questId);

    return {
      'totalCards': cards.length,
      'masteredCards': cards.where((c) => c.isMastered).length,
      'dueCards': cards.where((c) => c.isDue).length,
      'learningCards': cards
          .where((c) => c.srsLevel == SRSLevel.learning)
          .length,
      'reviewCards': cards.where((c) => c.srsLevel == SRSLevel.review).length,
      'newCards': cards.where((c) => c.srsLevel == SRSLevel.newCard).length,
      'progress': deck?.progress ?? 0.0,
      'isCompleted': deck?.isCompleted ?? false,
    };
  }

  /// Get counts for SRS buckets (Hard, Good, Easy) across all cards
  Future<Map<FlashcardRating, int>> getSRSBucketCounts() async {
    final hardCount = await _isar.flashcardItems
        .filter()
        .lastRatingIndexEqualTo(FlashcardRating.hard.index)
        .count();
    final goodCount = await _isar.flashcardItems
        .filter()
        .lastRatingIndexEqualTo(FlashcardRating.good.index)
        .count();
    final easyCount = await _isar.flashcardItems
        .filter()
        .lastRatingIndexEqualTo(FlashcardRating.easy.index)
        .count();

    return {
      FlashcardRating.hard: hardCount,
      FlashcardRating.good: goodCount,
      FlashcardRating.easy: easyCount,
    };
  }

  /// Get flashcards by rating for bucket-based practice
  Future<List<FlashcardItem>> getFlashcardsByRating(
    FlashcardRating rating,
  ) async {
    return await _isar.flashcardItems
        .filter()
        .lastRatingIndexEqualTo(rating.index)
        .findAll();
  }
}

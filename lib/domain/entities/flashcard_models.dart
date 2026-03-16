import 'package:isar/isar.dart';

part 'flashcard_models.g.dart';

/// Spaced Repetition System (SRS) levels
enum SRSLevel {
  newCard,
  learning,
  review,
  relearning,
}

/// Flashcard item with SRS metadata
@Collection()
class FlashcardItem {
  Id id = Isar.autoIncrement;

  /// Unique identifier for the flashcard
  @Index()
  late String cardId;

  /// Associated quest/lesson ID
  @Index()
  late String questId;

  /// Japanese text (Kanji/Hiragana)
  late String japanese;

  /// Kana reading
  late String kana;

  /// Romaji reading
  late String romaji;

  /// Vietnamese meaning
  late String meaning;

  /// Example sentence (optional)
  String? example;

  /// Example sentence meaning (optional)
  String? exampleMeaning;

  /// Note for the card (optional)
  String? note;

  /// SRS Level
  @enumerated
  late SRSLevel srsLevel;

  /// Ease factor (default 2.5)
  late double easeFactor;

  /// Interval in days
  late int interval;

  /// Number of repetitions
  late int repetitions;

  /// Next review date
  @Index()
  late DateTime nextReviewDate;

  /// Last review date
  DateTime? lastReviewDate;

  /// Number of times reviewed correctly
  late int correctCount;

  /// Number of times reviewed incorrectly
  late int incorrectCount;

  /// Whether the card is mastered (correctly reviewed 3+ times)
  late bool isMastered;

  /// Timestamp when card was created
  late DateTime createdAt;

  /// Timestamp when card was last updated
  late DateTime updatedAt;

  FlashcardItem();

  /// Create a new flashcard item
  factory FlashcardItem.create({
    required String cardId,
    required String questId,
    required String japanese,
    required String kana,
    required String romaji,
    required String meaning,
    String? example,
    String? exampleMeaning,
    String? note,
  }) {
    final now = DateTime.now();
    return FlashcardItem()
      ..cardId = cardId
      ..questId = questId
      ..japanese = japanese
      ..kana = kana
      ..romaji = romaji
      ..meaning = meaning
      ..example = example
      ..exampleMeaning = exampleMeaning
      ..note = note
      ..srsLevel = SRSLevel.newCard
      ..easeFactor = 2.5
      ..interval = 0
      ..repetitions = 0
      ..nextReviewDate = now
      ..correctCount = 0
      ..incorrectCount = 0
      ..isMastered = false
      ..createdAt = now
      ..updatedAt = now;
  }

  /// Update SRS data based on review result (true = remembered, false = forgotten)
  void updateSRS(bool remembered) {
    final now = DateTime.now();
    lastReviewDate = now;
    updatedAt = now;

    if (remembered) {
      correctCount++;
      repetitions++;

      // SM-2 Algorithm simplified
      if (repetitions == 1) {
        interval = 1;
      } else if (repetitions == 2) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }

      // Update ease factor
      easeFactor = easeFactor + (0.1 - (5 - 3) * (0.08 + (5 - 3) * 0.02));
      if (easeFactor < 1.3) easeFactor = 1.3;

      srsLevel = SRSLevel.review;

      // Mark as mastered after 3 correct reviews
      if (correctCount >= 3) {
        isMastered = true;
      }
    } else {
      incorrectCount++;
      repetitions = 0;
      interval = 1;
      easeFactor = easeFactor - 0.2;
      if (easeFactor < 1.3) easeFactor = 1.3;

      srsLevel = SRSLevel.learning;
      isMastered = false;
    }

    // Calculate next review date
    nextReviewDate = now.add(Duration(days: interval));
  }

  /// Check if card is due for review
  bool get isDue => DateTime.now().isAfter(nextReviewDate) || DateTime.now().isAtSameMomentAs(nextReviewDate);
}

/// Flashcard deck containing multiple cards
@Collection()
class FlashcardDeck {
  Id id = Isar.autoIncrement;

  /// Unique identifier for the deck
  @Index()
  late String deckId;

  /// Associated quest/lesson ID
  @Index()
  late String questId;

  /// Deck title
  late String title;

  /// Deck description
  String? description;

  /// Total number of cards in the deck
  late int totalCards;

  /// Number of mastered cards
  late int masteredCards;

  /// Number of cards due for review
  late int dueCards;

  /// Progress percentage (0.0 to 1.0)
  late double progress;

  /// Whether the deck is completed (all cards mastered)
  late bool isCompleted;

  /// Timestamp when deck was created
  late DateTime createdAt;

  /// Timestamp when deck was last updated
  late DateTime updatedAt;

  FlashcardDeck();

  /// Create a new flashcard deck
  factory FlashcardDeck.create({
    required String deckId,
    required String questId,
    required String title,
    String? description,
  }) {
    final now = DateTime.now();
    return FlashcardDeck()
      ..deckId = deckId
      ..questId = questId
      ..title = title
      ..description = description
      ..totalCards = 0
      ..masteredCards = 0
      ..dueCards = 0
      ..progress = 0.0
      ..isCompleted = false
      ..createdAt = now
      ..updatedAt = now;
  }

  /// Update deck statistics based on cards
  void updateStats(List<FlashcardItem> cards) {
    totalCards = cards.length;
    masteredCards = cards.where((c) => c.isMastered).length;
    dueCards = cards.where((c) => c.isDue).length;
    progress = totalCards > 0 ? masteredCards / totalCards : 0.0;
    isCompleted = totalCards > 0 && masteredCards == totalCards;
    updatedAt = DateTime.now();
  }
}

/// User progress history for tracking learning sessions
@Collection()
class UserProgressHistory {
  Id id = Isar.autoIncrement;

  /// Unique identifier for the history entry
  late String historyId;

  /// Associated quest/lesson ID
  @Index()
  late String questId;

  /// Session type (flashcard, lesson, test, etc.)
  late String sessionType;

  /// Number of cards/items reviewed
  late int itemsReviewed;

  /// Number of correct answers
  late int correctAnswers;

  /// Number of incorrect answers
  late int incorrectAnswers;

  /// Session duration in seconds
  late int durationSeconds;

  /// Progress percentage (0.0 to 1.0)
  late double progress;

  /// Whether the session was completed
  late bool isCompleted;

  /// XP earned from this session
  late int xpEarned;

  /// Timestamp when session started
  late DateTime startedAt;

  /// Timestamp when session ended
  late DateTime endedAt;

  UserProgressHistory();

  /// Create a new progress history entry
  factory UserProgressHistory.create({
    required String historyId,
    required String questId,
    required String sessionType,
    required int itemsReviewed,
    required int correctAnswers,
    required int incorrectAnswers,
    required int durationSeconds,
    required double progress,
    required bool isCompleted,
    required int xpEarned,
  }) {
    final now = DateTime.now();
    return UserProgressHistory()
      ..historyId = historyId
      ..questId = questId
      ..sessionType = sessionType
      ..itemsReviewed = itemsReviewed
      ..correctAnswers = correctAnswers
      ..incorrectAnswers = incorrectAnswers
      ..durationSeconds = durationSeconds
      ..progress = progress
      ..isCompleted = isCompleted
      ..xpEarned = xpEarned
      ..startedAt = now
      ..endedAt = now;
  }
}

import 'dart:math' as math;

import '../../domain/entities/card.dart';

/// Implementation of the SM-2 Spaced Repetition Algorithm
/// Based on: https://www.supermemo.com/en/archives1990-2015/english/ol/sm2
class SrsAlgorithm {
  SrsAlgorithm._();

  /// Minimum ease factor to prevent cards from becoming too difficult
  static const double minEaseFactor = 1.3;

  /// Initial ease factor for new cards
  static const double initialEaseFactor = 2.5;

  /// Calculate the next review state for a card based on quality rating
  ///
  /// [quality] must be between 0 and 5:
  /// - 0: Complete blackout
  /// - 1: Incorrect; correct answer remembered on seeing it
  /// - 2: Incorrect; correct answer seemed easy to recall
  /// - 3: Correct response recalled with serious difficulty
  /// - 4: Correct response after a hesitation
  /// - 5: Perfect response
  static Card calculateNextReview(Card card, int quality) {
    assert(quality >= 0 && quality <= 5, 'Quality must be between 0 and 5');

    double newEaseFactor = card.easeFactor;
    int newInterval = card.interval;
    int newRepetitions = card.repetitions;
    bool isLearned = card.isLearned;

    if (quality >= 3) {
      // Correct response
      if (newRepetitions == 0) {
        newInterval = 1;
      } else if (newRepetitions == 1) {
        newInterval = 6;
      } else {
        newInterval = (card.interval * card.easeFactor).round();
      }
      newRepetitions++;
      isLearned = true;
    } else {
      // Incorrect response - reset
      newRepetitions = 0;
      newInterval = 1;
      isLearned = false;
    }

    // Calculate new ease factor
    newEaseFactor =
        card.easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));

    // Ensure ease factor doesn't go below minimum
    newEaseFactor = math.max(minEaseFactor, newEaseFactor);

    // Calculate next due date
    final now = DateTime.now();
    final nextDueDate = now.add(Duration(days: newInterval));

    return card.copyWith(
      easeFactor: newEaseFactor,
      interval: newInterval,
      repetitions: newRepetitions,
      isLearned: isLearned,
      dueDate: nextDueDate,
      lastReviewedAt: now,
    );
  }

  /// Check if a card is due for review
  static bool isDue(Card card) {
    if (card.dueDate == null) return true;
    return card.dueDate!.isBefore(DateTime.now());
  }

  /// Get the next interval in human-readable format
  static String getIntervalText(int interval) {
    if (interval < 7) {
      return '$interval day${interval > 1 ? 's' : ''}';
    } else if (interval < 30) {
      final weeks = (interval / 7).round();
      return '$weeks week${weeks > 1 ? 's' : ''}';
    } else if (interval < 365) {
      final months = (interval / 30).round();
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      final years = (interval / 365).round();
      return '$years year${years > 1 ? 's' : ''}';
    }
  }

  /// Calculate estimated review intervals for each quality rating
  static Map<int, int> getEstimatedIntervals(Card card) {
    final intervals = <int, int>{};
    for (int quality = 0; quality <= 5; quality++) {
      final result = calculateNextReview(card, quality);
      intervals[quality] = result.interval;
    }
    return intervals;
  }
}

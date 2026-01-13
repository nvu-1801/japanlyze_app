import 'package:isar/isar.dart';

part 'card.g.dart';

@collection
class Card {
  Id id = Isar.autoIncrement;

  late int deckId;
  late String front;
  late String back;
  String? example;
  bool isLearned = false;

  // SRS fields
  double easeFactor = 2.5;
  int interval = 1;
  int repetitions = 0;
  DateTime? dueDate;
  DateTime? lastReviewedAt;

  Card({
    this.id = Isar.autoIncrement,
    required this.deckId,
    required this.front,
    required this.back,
    this.example,
    this.isLearned = false,
    this.easeFactor = 2.5,
    this.interval = 1,
    this.repetitions = 0,
    this.dueDate,
    this.lastReviewedAt,
  });

  Card copyWith({
    Id? id,
    int? deckId,
    String? front,
    String? back,
    String? example,
    bool? isLearned,
    double? easeFactor,
    int? interval,
    int? repetitions,
    DateTime? dueDate,
    DateTime? lastReviewedAt,
  }) {
    return Card(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      example: example ?? this.example,
      isLearned: isLearned ?? this.isLearned,
      easeFactor: easeFactor ?? this.easeFactor,
      interval: interval ?? this.interval,
      repetitions: repetitions ?? this.repetitions,
      dueDate: dueDate ?? this.dueDate,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
    );
  }
}

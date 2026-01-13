import 'package:isar/isar.dart';

part 'exercise_attempt.g.dart';

@collection
class ExerciseAttempt {
  Id id = Isar.autoIncrement;

  late int userId;
  late int exerciseId;
  int score = 0;
  int total = 0;
  int timeSpent = 0; // in seconds
  List<int> mistakes = []; // list of questionIds
  late DateTime createdAt;

  ExerciseAttempt({
    this.id = Isar.autoIncrement,
    required this.userId,
    required this.exerciseId,
    this.score = 0,
    this.total = 0,
    this.timeSpent = 0,
    this.mistakes = const [],
    required DateTime createdAt,
  }) : createdAt = createdAt;

  ExerciseAttempt copyWith({
    Id? id,
    int? userId,
    int? exerciseId,
    int? score,
    int? total,
    int? timeSpent,
    List<int>? mistakes,
    DateTime? createdAt,
  }) {
    return ExerciseAttempt(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      score: score ?? this.score,
      total: total ?? this.total,
      timeSpent: timeSpent ?? this.timeSpent,
      mistakes: mistakes ?? this.mistakes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

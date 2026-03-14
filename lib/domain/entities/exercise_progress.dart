import 'package:isar/isar.dart';

part 'exercise_progress.g.dart';

@collection
class ExerciseProgress {
  Id id = Isar.autoIncrement;
  late String uuid; // Prisma ID
  late String exerciseId;
  late int score;
  late DateTime completedAt;
  late String userId;

  ExerciseProgress({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.exerciseId,
    required this.score,
    required DateTime completedAt,
    required this.userId,
  }) : completedAt = completedAt;

  factory ExerciseProgress.fromJson(Map<String, dynamic> json) {
    return ExerciseProgress(
      uuid: json['id'],
      exerciseId: json['exerciseId'],
      score: json['score'],
      completedAt: DateTime.parse(json['completedAt']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'exerciseId': exerciseId,
      'score': score,
      'completedAt': completedAt.toIso8601String(),
      'userId': userId,
    };
  }
}

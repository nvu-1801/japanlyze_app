import 'dart:convert';
import 'package:isar/isar.dart';

part 'test_result.g.dart';

@collection
class TestResult {
  Id id = Isar.autoIncrement;
  late String uuid; // Prisma ID
  late int score;
  late int totalQuestions;
  late DateTime completedAt;
  late String userId;
  late String testId;
  late String answers; // JSON string of { questionId: selectedIndex }

  TestResult({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.score,
    required this.totalQuestions,
    required DateTime completedAt,
    required this.userId,
    required this.testId,
    required this.answers,
  }) : completedAt = completedAt;

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      uuid: json['id'],
      score: json['score'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : DateTime.now(),
      userId: json['userId'],
      testId: json['testId'],
      answers: json['answers'] is Map
          ? jsonEncode(json['answers'])
          : (json['answers'] ?? '{}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'score': score,
      'totalQuestions': totalQuestions,
      'completedAt': completedAt.toIso8601String(),
      'userId': userId,
      'testId': testId,
      'answers': jsonDecode(answers),
    };
  }
}

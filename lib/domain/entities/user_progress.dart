import 'package:isar/isar.dart';

part 'user_progress.g.dart';

@collection
class UserProgress {
  Id id = Isar.autoIncrement;

  late String uuid; // Prisma UUID
  late String userId;
  late String questId;
  late DateTime completedAt;

  UserProgress({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.userId,
    required this.questId,
    required DateTime completedAt,
  }) : completedAt = completedAt;

  UserProgress copyWith({
    Id? id,
    String? uuid,
    String? userId,
    String? questId,
    DateTime? completedAt,
  }) {
    return UserProgress(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      questId: questId ?? this.questId,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: Isar.autoIncrement,
      uuid: json['id'],
      userId: json['userId'],
      questId: json['questId'],
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'userId': userId,
      'questId': questId,
      'completedAt': completedAt.toIso8601String(),
    };
  }
}

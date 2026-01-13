import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  late String type; // 'kana', 'vocab', 'grammar', 'roleplay'
  late String title;
  String? description;
  List<String> prerequisites = [];
  bool isPremiumLocked = false;
  late DateTime createdAt;
  DateTime? updatedAt;

  Exercise({
    this.id = Isar.autoIncrement,
    required this.type,
    required this.title,
    this.description,
    this.prerequisites = const [],
    this.isPremiumLocked = false,
    required DateTime createdAt,
    this.updatedAt,
  }) : createdAt = createdAt;

  Exercise copyWith({
    Id? id,
    String? type,
    String? title,
    String? description,
    List<String>? prerequisites,
    bool? isPremiumLocked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      prerequisites: prerequisites ?? this.prerequisites,
      isPremiumLocked: isPremiumLocked ?? this.isPremiumLocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

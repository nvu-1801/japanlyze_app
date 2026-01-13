import 'package:isar/isar.dart';

part 'translation_history.g.dart';

@collection
class TranslationHistory {
  Id id = Isar.autoIncrement;

  int? userId;
  late String text;
  late String source; // 'ja', 'en', 'vi'
  late String target; // 'ja', 'en', 'vi'
  late String result;
  bool starred = false;
  late DateTime createdAt;

  TranslationHistory({
    this.id = Isar.autoIncrement,
    this.userId,
    required this.text,
    required this.source,
    required this.target,
    required this.result,
    this.starred = false,
    required DateTime createdAt,
  }) : createdAt = createdAt;

  TranslationHistory copyWith({
    Id? id,
    int? userId,
    String? text,
    String? source,
    String? target,
    String? result,
    bool? starred,
    DateTime? createdAt,
  }) {
    return TranslationHistory(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      source: source ?? this.source,
      target: target ?? this.target,
      result: result ?? this.result,
      starred: starred ?? this.starred,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

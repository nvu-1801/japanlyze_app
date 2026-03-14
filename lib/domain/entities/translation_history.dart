import 'package:isar/isar.dart';

part 'translation_history.g.dart';

@collection
class TranslationHistory {
  Id id = Isar.autoIncrement;

  late String uuid; // Prisma ID
  String? userId;
  late String sourceText;
  late String targetText;
  late String sourceLang; // 'ja', 'en', 'vi'
  late String targetLang; // 'ja', 'en', 'vi'
  bool starred = false;
  late DateTime createdAt;

  TranslationHistory({
    this.id = Isar.autoIncrement,
    required this.uuid,
    this.userId,
    required this.sourceText,
    required this.targetText,
    required this.sourceLang,
    required this.targetLang,
    this.starred = false,
    required DateTime createdAt,
  }) : createdAt = createdAt;

  TranslationHistory copyWith({
    Id? id,
    String? uuid,
    String? userId,
    String? sourceText,
    String? targetText,
    String? sourceLang,
    String? targetLang,
    bool? starred,
    DateTime? createdAt,
  }) {
    return TranslationHistory(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      sourceText: sourceText ?? this.sourceText,
      targetText: targetText ?? this.targetText,
      sourceLang: sourceLang ?? this.sourceLang,
      targetLang: targetLang ?? this.targetLang,
      starred: starred ?? this.starred,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TranslationHistory.fromJson(Map<String, dynamic> json) {
    return TranslationHistory(
      uuid: json['id'],
      userId: json['userId'],
      sourceText: json['sourceText'],
      targetText: json['targetText'],
      sourceLang: json['sourceLang'] ?? 'ja',
      targetLang: json['targetLang'] ?? 'vi',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'userId': userId,
      'sourceText': sourceText,
      'targetText': targetText,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

// lib/domain/entities/reading_article.dart
import 'package:equatable/equatable.dart';

class ReadingArticle extends Equatable {
  final String id;
  final String title;
  final String? excerpt;
  final String? content;
  final String? contentRomaji;
  final String? contentMeaning;
  final String level;
  final String? topic;
  final String? image;

  const ReadingArticle({
    required this.id,
    required this.title,
    this.excerpt,
    this.content,
    this.contentRomaji,
    this.contentMeaning,
    required this.level,
    this.topic,
    this.image,
  });

  factory ReadingArticle.fromJson(Map<String, dynamic> json) {
    return ReadingArticle(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      excerpt: json['excerpt'] as String?,
      content: json['content'] as String?,
      contentRomaji: json['contentRomaji'] as String?,
      contentMeaning: json['contentMeaning'] as String?,
      level: json['level'] as String? ?? 'N5',
      topic: json['topic'] as String?,
      image: json['image'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, title, level];
}

class ReadingSegment {
  final String japanese;
  final String? romaji;
  final String? meaning;

  ReadingSegment({required this.japanese, this.romaji, this.meaning});
}

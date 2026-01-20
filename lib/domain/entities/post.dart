import 'package:isar/isar.dart';

part 'post.g.dart';

@collection
class Post {
  Id id = Isar.autoIncrement;

  late String uuid; // Supabase UUID
  late String content;
  late int rating; // 1-5 stars
  late String userId; // Foreign key to User (UUID)
  late DateTime createdAt;

  Post({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.content,
    this.rating = 5,
    required this.userId,
    required DateTime createdAt,
  }) : createdAt = createdAt;

  Post copyWith({
    Id? id,
    String? uuid,
    String? content,
    int? rating,
    String? userId,
    DateTime? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: Isar.autoIncrement,
      uuid: json['id'],
      content: json['content'],
      rating: json['rating'] ?? 5,
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'content': content,
      'rating': rating,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

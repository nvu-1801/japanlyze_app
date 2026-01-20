import 'package:isar/isar.dart';

part 'comment.g.dart';

@collection
class Comment {
  Id id = Isar.autoIncrement;

  late String uuid; // Supabase UUID
  late String content;
  late String postId; // Foreign key to Post (UUID)
  late String userId; // Foreign key to User (UUID)
  late DateTime createdAt;

  Comment({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.content,
    required this.postId,
    required this.userId,
    required DateTime createdAt,
  }) : createdAt = createdAt;

  Comment copyWith({
    Id? id,
    String? uuid,
    String? content,
    String? postId,
    String? userId,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: Isar.autoIncrement,
      uuid: json['id'],
      content: json['content'],
      postId: json['postId'],
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
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

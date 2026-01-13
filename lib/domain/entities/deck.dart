import 'package:isar/isar.dart';

part 'deck.g.dart';

@collection
class Deck {
  Id id = Isar.autoIncrement;

  late String title;
  String? description;
  late int userId;
  int cardCount = 0;
  int dueCount = 0;
  late DateTime createdAt;
  DateTime? updatedAt;

  Deck({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description,
    required this.userId,
    this.cardCount = 0,
    this.dueCount = 0,
    required DateTime createdAt,
    this.updatedAt,
  }) : createdAt = createdAt;

  Deck copyWith({
    Id? id,
    String? title,
    String? description,
    int? userId,
    int? cardCount,
    int? dueCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      cardCount: cardCount ?? this.cardCount,
      dueCount: dueCount ?? this.dueCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

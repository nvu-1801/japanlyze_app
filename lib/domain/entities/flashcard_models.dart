
class Flashcard {
  final String id;
  final String front;
  final String back;

  Flashcard({
    required this.id,
    required this.front,
    required this.back,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'front': front,
    'back': back,
  };

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
    id: json['id'],
    front: json['front'],
    back: json['back'],
  );
}

class FlashcardSet {
  final String id;
  final String title;
  final List<Flashcard> cards;
  final int masteredCount; // Optional: track progress if manageable
  final int studiedCount;

  FlashcardSet({
    required this.id,
    required this.title,
    required this.cards,
    this.masteredCount = 0,
    this.studiedCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'cards': cards.map((c) => c.toJson()).toList(),
    'masteredCount': masteredCount,
    'studiedCount': studiedCount,
  };

  factory FlashcardSet.fromJson(Map<String, dynamic> json) => FlashcardSet(
    id: json['id'],
    title: json['title'],
    cards: (json['cards'] as List).map((c) => Flashcard.fromJson(c)).toList(),
    masteredCount: json['masteredCount'] ?? 0,
    studiedCount: json['studiedCount'] ?? 0,
  );
}

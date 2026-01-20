
/// Enum for character names
enum CharacterName {
  aki,
  daigo,
  chiki,
  isora,
}

/// A segment of text, possibly with furigana
class Segment {
  final String text;
  final String? furigana;

  const Segment({
    required this.text,
    this.furigana,
  });
}

/// A single line of dialogue or a quiz item
class DialogueLine {
  final int id;
  final CharacterName speaker;
  final List<Segment> segments;
  final String kana;
  final String romaji;
  final String meaning;
  final bool isQuiz;
  final List<Segment>? quizQuestion;
  final List<String>? quizOptions;
  final int? correctOptionIndex;

  const DialogueLine({
    required this.id,
    required this.speaker,
    this.segments = const [], // Made optional/default empty for safety
    required this.kana,
    required this.romaji,
    required this.meaning,
    this.isQuiz = false,
    this.quizQuestion,
    this.quizOptions,
    this.correctOptionIndex,
  });
}

/// A vocabulary item
class VocabItem {
  final String kanji;
  final String kana;
  final String romaji;
  final String meaning;
  final String? note;

  const VocabItem({
    this.kanji = '',
    required this.kana,
    this.romaji = '',
    required this.meaning,
    this.note,
  });
}

/// A full conversation, vocabulary, or quiz lesson
class ConversationLesson {
  final String id;
  final String title;
  final String description;
  final List<CharacterName> characters;
  final List<String> prerequisites;
  final List<DialogueLine> lines;
  final List<VocabItem> vocabItems; // New field for vocabulary

  const ConversationLesson({
    required this.id,
    required this.title,
    required this.description,
    this.characters = const [],
    this.prerequisites = const [],
    this.lines = const [],
    this.vocabItems = const [],
  });
}

/// A lesson item displayed in the UI list
class LessonItem {
  final String id;
  final String title;
  final dynamic icon; // IconData in data file
  final dynamic color; // Color for icon
  final dynamic backgroundColor; // Color for background

  const LessonItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}

/// A category of lessons
class LessonCategory {
  final String title;
  final List<LessonItem> lessons;

  const LessonCategory({
    required this.title,
    required this.lessons,
  });
}

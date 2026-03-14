import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final String id;
  final String title;
  final String level;
  final int duration;
  final bool isPremium;
  final int questionCount;
  final List<Question>? questions;

  const Exam({
    required this.id,
    required this.title,
    required this.level,
    required this.duration,
    required this.isPremium,
    required this.questionCount,
    this.questions,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    final count = json['_count'] as Map<String, dynamic>?;
    final questionsJson = json['questions'] as List<dynamic>?;
    return Exam(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled Exam',
      level: json['level'] as String? ?? 'N?',
      duration: json['duration'] as int? ?? 0,
      isPremium: json['isPremium'] as bool? ?? false,
      questionCount:
          count?['questions'] as int? ?? (questionsJson?.length ?? 0),
      questions: questionsJson?.map((q) => Question.fromJson(q)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'level': level,
      'duration': duration,
      'isPremium': isPremium,
      '_count': {'questions': questionCount},
      if (questions != null)
        'questions': questions!.map((q) => q.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    level,
    duration,
    isPremium,
    questionCount,
    questions,
  ];
}

class Question extends Equatable {
  final String id;
  final String content;
  final String type;
  final List<String> options;
  final int correctAnswer;
  final String? explanation;
  final String? imageUrl;
  final String? audioUrl;

  const Question({
    required this.id,
    required this.content,
    required this.type,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.imageUrl,
    this.audioUrl,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'] as int,
      explanation: json['explanation'] as String?,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }

  @override
  List<Object?> get props => [
    id,
    content,
    type,
    options,
    correctAnswer,
    explanation,
    imageUrl,
    audioUrl,
  ];
}

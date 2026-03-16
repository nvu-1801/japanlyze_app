import 'package:equatable/equatable.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../domain/entities/roadmap_models.dart';
import '../../../../domain/entities/user.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

/// Initial state - no data loaded yet
class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

/// Loading state - showing skeleton loaders
class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

/// Loaded state - contains all dashboard data
class DashboardLoaded extends DashboardState {
  final User user;
  final RoadmapQuest? nextMilestone;
  final List<LessonItem> recommendedExercises;
  final List<LessonItem> flashcardDecks;
  final int currentStreak;
  final DateTime? lastStudyDate;
  final int displayedXP; // For counting animation
  final String currentJlptLevel;

  const DashboardLoaded({
    required this.user,
    this.nextMilestone,
    this.recommendedExercises = const [],
    this.flashcardDecks = const [],
    this.currentStreak = 0,
    this.lastStudyDate,
    this.displayedXP = 0,
    this.currentJlptLevel = 'N5',
  });

  /// Check if user has completed all quests
  bool get isRoadmapComplete => nextMilestone == null;

  /// Get progress percentage for next milestone
  double get nextMilestoneProgress {
    // This would be calculated from quest progress
    // For now, return a default value
    return 0.0;
  }

  DashboardLoaded copyWith({
    User? user,
    RoadmapQuest? nextMilestone,
    List<LessonItem>? recommendedExercises,
    List<LessonItem>? flashcardDecks,
    int? currentStreak,
    DateTime? lastStudyDate,
    int? displayedXP,
    String? currentJlptLevel,
  }) {
    return DashboardLoaded(
      user: user ?? this.user,
      nextMilestone: nextMilestone ?? this.nextMilestone,
      recommendedExercises: recommendedExercises ?? this.recommendedExercises,
      flashcardDecks: flashcardDecks ?? this.flashcardDecks,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      displayedXP: displayedXP ?? this.displayedXP,
      currentJlptLevel: currentJlptLevel ?? this.currentJlptLevel,
    );
  }

  @override
  List<Object?> get props => [
    user,
    nextMilestone,
    recommendedExercises,
    flashcardDecks,
    currentStreak,
    lastStudyDate,
    displayedXP,
    currentJlptLevel,
  ];
}

/// Error state - something went wrong
class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Empty state - new user with no data
class DashboardEmpty extends DashboardState {
  const DashboardEmpty();
}

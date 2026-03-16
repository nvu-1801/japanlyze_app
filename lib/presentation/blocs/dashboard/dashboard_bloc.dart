import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../../../data/datasources/local/roadmap_data.dart';
import '../../../../data/services/user_progress_service.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../domain/entities/roadmap_models.dart';
import '../auth/auth_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AuthBloc authBloc;
  final UserProgressService progressService;

  // Streak tracking keys
  static const String _streakKey = 'user_streak';
  static const String _lastStudyDateKey = 'last_study_date';

  DashboardBloc({
    required this.authBloc,
    required this.progressService,
  }) : super(const DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoadRequested);
    on<DashboardRefreshRequested>(_onRefreshRequested);
    on<DashboardXpUpdated>(_onXpUpdated);
    on<DashboardLessonCompleted>(_onLessonCompleted);
  }

  /// Load dashboard data
  Future<void> _onLoadRequested(
    DashboardLoadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());

    try {
      // Get current user from AuthBloc
      final authState = authBloc.state;
      if (authState is! AuthAuthenticated) {
        emit(const DashboardError('User not authenticated'));
        return;
      }

      final user = authState.user;

      // Load completed lessons
      final completedLessons = await progressService.getCompletedLessons();

      // Find next milestone (dynamic logic)
      final nextMilestone = _findNextMilestone(completedLessons);

      // Generate smart recommendations (always populate, even for new users)
      final recommendations = _generateRecommendations(completedLessons);

      // Get flashcard decks (always populate, even for new users)
      final flashcardDecks = _getFlashcardDecks();

      // Calculate streak
      final streakData = await _calculateStreak();

      emit(DashboardLoaded(
        user: user,
        nextMilestone: nextMilestone,
        recommendedExercises: recommendations,
        flashcardDecks: flashcardDecks,
        currentStreak: streakData['streak'] as int,
        lastStudyDate: streakData['lastDate'] as DateTime?,
        displayedXP: user.exp,
      ));
    } catch (e) {
      emit(DashboardError('Failed to load dashboard: ${e.toString()}'));
    }
  }

  /// Refresh dashboard data
  Future<void> _onRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    // Re-trigger load
    add(const DashboardLoadRequested());
  }

  /// Update XP with counting animation
  Future<void> _onXpUpdated(
    DashboardXpUpdated event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardLoaded) return;

    final currentState = state as DashboardLoaded;
    final oldXP = currentState.displayedXP;
    final newXP = event.newXP;

    // Animate XP count up
    if (newXP > oldXP) {
      final steps = 20;
      final increment = (newXP - oldXP) / steps;

      for (int i = 1; i <= steps; i++) {
        await Future.delayed(const Duration(milliseconds: 30));
        final currentXP = (oldXP + (increment * i)).round();
        emit(currentState.copyWith(displayedXP: currentXP));
      }
    }

    // Final state with actual XP
    emit(currentState.copyWith(displayedXP: newXP));
  }

  /// Handle lesson completion
  Future<void> _onLessonCompleted(
    DashboardLessonCompleted event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardLoaded) return;

    final currentState = state as DashboardLoaded;

    // Mark lesson as completed
    await progressService.markLessonAsCompleted(event.lessonId);

    // Update streak
    await _updateStreak();

    // Update user XP (this would typically be done via a repository)
    final newXP = currentState.user.exp + event.xpEarned;

    // Trigger XP animation
    add(DashboardXpUpdated(newXP));

    // Reload dashboard to get updated recommendations
    add(const DashboardLoadRequested());
  }

  /// Find the next available milestone (dynamic logic)
  RoadmapQuest? _findNextMilestone(List<String> completedLessons) {
    // Flatten all quests from all weeks
    final allQuests = n5Weeks.expand((week) => week.quests).toList();

    // Sort by ID to get the smallest order
    allQuests.sort((a, b) => a.id.compareTo(b.id));

    // Find the first quest that is NOT completed
    for (final quest in allQuests) {
      if (!completedLessons.contains(quest.id)) {
        return quest;
      }
    }

    // All quests completed
    return null;
  }

  /// Generate smart recommendations (Phase 1 algorithm)
  List<LessonItem> _generateRecommendations(List<String> completedLessons) {
    final recommendations = <LessonItem>[];

    // 1. Get 2 items from vocabulary category (flashcard-like)
    final vocabItems = exerciseCategories[1].lessons.take(2).toList();
    recommendations.addAll(vocabItems);

    // 2. Get 2 items from conversation category (grammar-like)
    final convItems = exerciseCategories[0].lessons.take(2).toList();
    recommendations.addAll(convItems);

    // 3. Get 1 new lesson (not completed)
    final newLesson = exerciseCategories
        .expand((cat) => cat.lessons)
        .firstWhere(
          (lesson) => !completedLessons.contains(lesson.id),
          orElse: () => exerciseCategories.first.lessons.first,
        );
    recommendations.add(newLesson);

    // Limit to 5 items
    return recommendations.take(5).toList();
  }

  /// Get flashcard decks for display
  List<LessonItem> _getFlashcardDecks() {
    // Get vocabulary categories for sample decks
    return exerciseCategories[1].lessons.take(4).toList();
  }

  /// Calculate current streak
  Future<Map<String, dynamic>> _calculateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final streak = prefs.getInt(_streakKey) ?? 0;
    final lastStudyDateStr = prefs.getString(_lastStudyDateKey);

    DateTime? lastStudyDate;
    if (lastStudyDateStr != null) {
      lastStudyDate = DateTime.parse(lastStudyDateStr);
    }

    return {
      'streak': streak,
      'lastDate': lastStudyDate,
    };
  }

  /// Update streak after completing a lesson
  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final lastStudyDateStr = prefs.getString(_lastStudyDateKey);
    DateTime? lastStudyDate;

    if (lastStudyDateStr != null) {
      lastStudyDate = DateTime.parse(lastStudyDateStr);
      final lastDate = DateTime(
        lastStudyDate.year,
        lastStudyDate.month,
        lastStudyDate.day,
      );

      final difference = today.difference(lastDate).inDays;

      if (difference == 0) {
        // Already studied today, no change
        return;
      } else if (difference == 1) {
        // Consecutive day, increment streak
        final currentStreak = prefs.getInt(_streakKey) ?? 0;
        await prefs.setInt(_streakKey, currentStreak + 1);
      } else {
        // Streak broken, reset to 1
        await prefs.setInt(_streakKey, 1);
      }
    } else {
      // First time studying
      await prefs.setInt(_streakKey, 1);
    }

    // Update last study date
    await prefs.setString(_lastStudyDateKey, now.toIso8601String());
  }
}

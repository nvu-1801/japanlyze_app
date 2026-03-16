import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load dashboard data
class DashboardLoadRequested extends DashboardEvent {
  const DashboardLoadRequested();
}

/// Event to refresh dashboard data
class DashboardRefreshRequested extends DashboardEvent {
  const DashboardRefreshRequested();
}

/// Event to update XP (for counting animation)
class DashboardXpUpdated extends DashboardEvent {
  final int newXP;

  const DashboardXpUpdated(this.newXP);

  @override
  List<Object?> get props => [newXP];
}

/// Event to mark a lesson as completed
class DashboardLessonCompleted extends DashboardEvent {
  final String lessonId;
  final int xpEarned;

  const DashboardLessonCompleted({
    required this.lessonId,
    required this.xpEarned,
  });

  @override
  List<Object?> get props => [lessonId, xpEarned];
}

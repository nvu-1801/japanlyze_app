import 'package:shared_preferences/shared_preferences.dart';

class UserProgressService {
  static const String _completedLessonsKey = 'completed_lessons';

  // Singleton instance
  static final UserProgressService _instance = UserProgressService._internal();
  factory UserProgressService() => _instance;
  UserProgressService._internal();

  /// Load completed lessons from SharedPreferences
  Future<List<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedLessonsKey) ?? [];
  }

  /// Mark a lesson as completed
  Future<void> markLessonAsCompleted(String lessonId) async {
    await markMultipleAsCompleted([lessonId]);
  }

  /// Mark multiple IDs as completed (e.g. both Quest ID and Lesson ID)
  Future<void> markMultipleAsCompleted(List<String?> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedLessonsKey) ?? [];

    bool changed = false;
    for (final id in ids) {
      if (id != null && id.isNotEmpty && !completed.contains(id)) {
        completed.add(id);
        changed = true;
      }
    }

    if (changed) {
      await prefs.setStringList(_completedLessonsKey, completed);
    }
  }

  /// Reset progress (for testing/debugging)
  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completedLessonsKey);
  }
}

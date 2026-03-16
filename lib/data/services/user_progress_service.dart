import 'package:shared_preferences/shared_preferences.dart';

class UserProgressService {
  static const String _completedLessonsKey = 'completed_lessons';
  static const String _questProgressKey = 'quest_progress_';

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

  /// Get progress for a specific quest (0.0 to 1.0)
  Future<double> getQuestProgress(String questId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('$_questProgressKey$questId') ?? 0.0;
  }

  /// Update progress for a specific quest (0.0 to 1.0)
  Future<void> updateQuestProgress(String questId, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_questProgressKey$questId', progress.clamp(0.0, 1.0));
  }

  /// Get all quest progress as a map
  Future<Map<String, double>> getAllQuestProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_questProgressKey));
    final Map<String, double> progressMap = {};
    
    for (final key in keys) {
      final questId = key.substring(_questProgressKey.length);
      final progress = prefs.getDouble(key) ?? 0.0;
      progressMap[questId] = progress;
    }
    
    return progressMap;
  }

  /// Reset progress (for testing/debugging)
  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completedLessonsKey);
    
    // Clear all quest progress
    final keys = prefs.getKeys().where((key) => key.startsWith(_questProgressKey));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}

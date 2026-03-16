import '../../../../../data/datasources/local/roadmap_data.dart';
import '../../../../../domain/entities/roadmap_models.dart';

/// Utility class for roadmap-related helper functions
class RoadmapUtils {
  /// Maps a web link to a quest ID
  static String mapLinkToId(String link) {
    if (link.contains('hiragana')) return 'hiragana';
    if (link.contains('katakana')) return 'katakana';

    final lessonMatch =
        RegExp(r'lesson=lesson(\d+)').firstMatch(link) ??
        RegExp(r'/lesson/(\d+)').firstMatch(link);
    if (lessonMatch != null) {
      final index = lessonMatch.group(1);
      switch (index) {
        case '1':
          return 'conv_1_intro';
        case '2':
          return 'conv_2_hometown';
        case '3':
          return 'conv_3_friends';
        case '4':
          return 'conv_4_subject';
        case '5':
          return 'conv_5_job';
      }
    }

    // Fallback: extract the last part of the path
    final parts = link.split('/');
    if (parts.isNotEmpty) {
      final last = parts.last;
      if (last.isNotEmpty) return last;
    }

    return link.replaceAll('/', '');
  }

  /// Checks if a quest is locked based on completed quests
  static bool isQuestLocked(
    RoadmapQuest quest,
    Set<String> completedQuestIds,
    List<RoadmapWeek> weeks,
  ) {
    final allQuests = weeks.expand((w) => w.quests).toList();
    final index = allQuests.indexWhere((q) => q.id == quest.id);

    // Ensure the very first quest is always unlocked
    if (index <= 0) return false;

    // A quest is locked if the directly preceding quest is NOT completed
    final prevQuest = allQuests[index - 1];
    return !completedQuestIds.contains(prevQuest.id);
  }

  /// Calculates progress percentage
  static int calculateProgress(int completed, int total) {
    return total > 0 ? (completed / total * 100).round() : 0;
  }

  /// Gets the next available quest index
  static int getNextAvailableQuestIndex(
    Set<String> completedQuestIds,
    List<RoadmapWeek> weeks,
  ) {
    final allQuests = weeks.expand((w) => w.quests).toList();
    return allQuests.indexWhere(
      (q) => !completedQuestIds.contains(q.id),
    );
  }

  /// Gets total quest count
  static int getTotalQuestCount(List<RoadmapWeek> weeks) {
    return weeks.expand((w) => w.quests).length;
  }

  /// Gets all quest IDs in the roadmap
  static Set<String> getAllQuestIds(List<RoadmapWeek> weeks) {
    return weeks.expand((w) => w.quests).map((q) => q.id).toSet();
  }

  /// Gets completed quest count
  static int getCompletedQuestCount(
    Set<String> completedQuestIds,
    List<RoadmapWeek> weeks,
  ) {
    final questIdsInRoadmap = getAllQuestIds(weeks);
    return completedQuestIds.intersection(questIdsInRoadmap).length;
  }
}

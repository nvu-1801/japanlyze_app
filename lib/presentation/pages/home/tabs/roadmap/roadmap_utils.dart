import '../../../../../data/datasources/local/roadmap_data.dart';
import '../../../../../domain/entities/roadmap_models.dart';

/// Utility class for roadmap-related helper functions
class RoadmapUtils {
  /// Maps a web link to a quest ID
  static String mapLinkToId(String link) {
    if (link.contains('hiragana')) return 'hiragana';
    if (link.contains('katakana')) return 'katakana';

    // N4 mappings
    if (link.contains('nature')) return 'n4_w1_2';
    if (link.contains('grammar-n4-1')) return 'n4_w1_3';
    if (link.contains('society')) return 'n4_w2_1';
    if (link.contains('keigo-basic')) return 'n4_w2_2';
    if (link.contains('roleplay-work')) return 'n4_w2_3';
    if (link.contains('kanji-n4-1')) return 'n4_w3_1';
    if (link.contains('reading-signs')) return 'n4_w3_2';
    if (link.contains('listening-n4')) return 'n4_w4_1';
    if (link.contains('mock-test-n4')) return 'n4_w4_2';

    // N3 mappings
    if (link.contains('grammar') &&
        !link.contains('n4') &&
        !link.contains('n2') &&
        !link.contains('n1'))
      return 'n3_w1_1';
    if (link.contains('complex-sentences')) return 'n3_w1_2';
    if (link.contains('vocab-n3-emotions')) return 'n3_w2_1';
    if (link.contains('grammar-n3-giving')) return 'n3_w2_2';
    if (link.contains('kanji-n3-jukugo')) return 'n3_w3_1';
    if (link.contains('reading-n3-news')) return 'n3_w3_2';
    if (link.contains('listening-n3-keywords')) return 'n3_w4_1';
    if (link.contains('mock-test-n3')) return 'n3_w4_2';

    // N2 mappings
    if (link.contains('kanji') && !link.contains('n3') && !link.contains('n1'))
      return 'n2_w1_1';
    if (link.contains('compound-kanji')) return 'n2_w1_2';
    if (link.contains('grammar-n2-formal')) return 'n2_w2_1';
    if (link.contains('reading-n2-opinions')) return 'n2_w2_2';
    if (link.contains('vocab-n2-business')) return 'n2_w3_1';
    if (link.contains('keigo-advanced')) return 'n2_w3_2';
    if (link.contains('listening-n2-news')) return 'n2_w4_1';
    if (link.contains('mock-test-n2')) return 'n2_w4_2';

    // N1 mappings
    if (link.contains('advanced-grammar')) return 'n1_w1_1';
    if (link.contains('nuanced-expressions')) return 'n1_w1_2';
    if (link.contains('kanji-n1-metaphors')) return 'n1_w2_1';
    if (link.contains('reading-n1-essays')) return 'n1_w2_2';
    if (link.contains('listening-n1-speech')) return 'n1_w3_1';
    if (link.contains('grammar-n1-idioms')) return 'n1_w3_2';
    if (link.contains('reading-n1-skimming')) return 'n1_w4_1';
    if (link.contains('mock-test-n1')) return 'n1_w4_2';

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
    return allQuests.indexWhere((q) => !completedQuestIds.contains(q.id));
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

import 'package:flutter/material.dart';
import '../../../../../../domain/entities/roadmap_models.dart';

/// Utility class for dashboard-related helper functions
class DashboardUtils {
  /// Gets icon for quest type
  static IconData getIconForType(String type) {
    switch (type) {
      case 'learn':
        return Icons.book_outlined;
      case 'test':
        return Icons.edit_outlined;
      case 'reading':
        return Icons.visibility_outlined;
      case 'flashcard':
        return Icons.bolt;
      case 'roleplay':
        return Icons.mic_none;
      case 'community':
        return Icons.people_outlined;
      default:
        return Icons.school_rounded;
    }
  }

  /// Calculates progress percentage
  static int calculateProgress(int completed, int total) {
    return total > 0 ? (completed / total * 100).round() : 0;
  }

  /// Formats XP value for display
  static String formatXP(int xp) {
    if (xp >= 1000) {
      return '${(xp / 1000).toStringAsFixed(1)}k';
    }
    return xp.toString();
  }

  /// Gets greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Ohayou';
    if (hour < 18) return 'Konnichiwa';
    return 'Konbanwa';
  }
}

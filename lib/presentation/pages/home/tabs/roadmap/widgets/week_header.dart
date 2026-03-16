import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../domain/entities/roadmap_models.dart';
import '../roadmap_utils.dart';

/// Widget displaying the week header with progress information
class WeekHeader extends StatelessWidget {
  final RoadmapWeek week;
  final Set<String> completedQuestIds;

  const WeekHeader({
    super.key,
    required this.week,
    required this.completedQuestIds,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final weekQuestIds = week.quests.map((q) => q.id).toSet();
    final completedCount = completedQuestIds.intersection(weekQuestIds).length;
    final totalCount = week.quests.length;
    final percentage = RoadmapUtils.calculateProgress(completedCount, totalCount);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: week.color.withValues(alpha: isDark ? 0.1 : 1.0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: week.iconColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: week.iconColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: week.iconColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week.title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: isDark ? Colors.white : Colors.blueGrey[800],
                  ),
                ),
                Text(
                  week.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                '$percentage%',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: week.iconColor,
                ),
              ),
              Text(
                '$completedCount/$totalCount',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

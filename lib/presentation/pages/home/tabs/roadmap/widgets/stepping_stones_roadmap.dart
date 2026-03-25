import 'package:japalyze/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../domain/entities/roadmap_models.dart';
import '../roadmap_utils.dart';

/// Stepping Stones Roadmap Widget - Modern minimalist design
class SteppingStonesRoadmap extends StatelessWidget {
  final List<RoadmapQuest> quests;
  final Set<String> completedQuestIds;
  final Map<String, double> questProgress;
  final Function(RoadmapQuest) onQuestTap;
  final Color primaryColor;
  final Color iconColor;
  final List<RoadmapWeek> weeks;

  const SteppingStonesRoadmap({
    super.key,
    required this.quests,
    required this.completedQuestIds,
    required this.questProgress,
    required this.onQuestTap,
    required this.primaryColor,
    required this.iconColor,
    required this.weeks,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: List.generate(quests.length, (index) {
          final quest = quests[index];
          final isDone = completedQuestIds.contains(quest.id);
          final isLocked = RoadmapUtils.isQuestLocked(quest, completedQuestIds, weeks);
          final isAvailable = !isLocked && !isDone;
          final progress = questProgress[quest.id] ?? 0.0;
          final isLast = index == quests.length - 1;

          return Column(
            children: [
              _buildQuestNode(
                context,
                quest,
                isDone,
                isLocked,
                isAvailable,
                progress,
                isDark,
              ),
              if (!isLast) _buildConnector(isDone, isLocked, isDark),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildQuestNode(
    BuildContext context,
    RoadmapQuest quest,
    bool isDone,
    bool isLocked,
    bool isAvailable,
    double progress,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () => onQuestTap(quest),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            // Node circle
            _buildNodeCircle(quest, isDone, isLocked, isAvailable, progress, isDark),
            const SizedBox(width: 16),
            // Quest info
            Expanded(
              child: _buildQuestInfo(
                context,
                quest,
                isDone,
                isLocked,
                isAvailable,
                progress,
                isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeCircle(
    RoadmapQuest quest,
    bool isDone,
    bool isLocked,
    bool isAvailable,
    double progress,
    bool isDark,
  ) {
    double size = 56.0;
    Color backgroundColor;
    Color borderColor;
    Widget? child;

    if (isDone) {
      backgroundColor = AppColors.primary.withValues(alpha: 0.1);
      borderColor = AppColors.primary;
      child = Icon(
        Icons.check_rounded,
        color: AppColors.primary,
        size: 28,
      );
    } else if (isLocked) {
      backgroundColor = isDark ? Colors.grey[900]! : Colors.grey[100]!;
      borderColor = isDark ? Colors.grey[800]! : Colors.grey[200]!;
      child = Icon(
        Icons.lock_rounded,
        color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
        size: 24,
      );
    } else {
      backgroundColor = primaryColor.withValues(alpha: 0.1);
      borderColor = iconColor;
      if (progress > 0) {
        child = Text(
          '${(progress * 100).toInt()}%',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        );
      } else {
        child = Icon(
          quest.icon,
          color: iconColor,
          size: 24,
        );
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 3,
        ),
        boxShadow: isAvailable
            ? [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(child: child),
    );
  }

  Widget _buildQuestInfo(
    BuildContext context,
    RoadmapQuest quest,
    bool isDone,
    bool isLocked,
    bool isAvailable,
    double progress,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? (isDark ? Colors.grey[900]! : Colors.grey[50]!)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDone
              ? AppColors.primary.withValues(alpha: 0.3)
              : (isDark ? Colors.grey[800]! : Colors.grey[100]!),
          width: 1,
        ),
        boxShadow: isAvailable
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quest.title,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isLocked
                  ? (isDark ? Colors.grey[600]! : Colors.grey[400]!)
                  : (isDark ? Colors.white : Colors.grey[800]!),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            quest.description,
            style: GoogleFonts.lexend(
              fontSize: 13,
              color: isLocked
                  ? (isDark ? Colors.grey[700]! : Colors.grey[400]!)
                  : Colors.grey[600],
            ),
          ),
          if (!isLocked && progress > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                valueColor: AlwaysStoppedAnimation(iconColor),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnector(bool isDone, bool isLocked, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(left: 28, top: 4, bottom: 4),
      height: 24,
      width: 3,
      decoration: BoxDecoration(
        color: isDone
            ? AppColors.primary
            : (isLocked
                ? (isDark ? Colors.grey[800]! : Colors.grey[200]!)
                : iconColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

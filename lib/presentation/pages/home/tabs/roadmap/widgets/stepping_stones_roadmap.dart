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
          final isLocked = RoadmapUtils.isQuestLocked(
            quest,
            completedQuestIds,
            weeks,
          );
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
            _buildNodeCircle(
              quest,
              isDone,
              isLocked,
              isAvailable,
              progress,
              isDark,
            ),
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
    Color backgroundColor;
    Color borderColor;
    Widget? child;

    if (isDone) {
      backgroundColor = AppColors.primary.withValues(alpha: 0.1);
      borderColor = AppColors.primary;
      child = Icon(Icons.check_rounded, color: AppColors.primary, size: 20);
    } else if (isLocked) {
      backgroundColor = isDark ? Colors.grey[900]! : Colors.grey[100]!;
      borderColor = isDark ? Colors.grey[800]! : Colors.grey[200]!;
      child = Icon(
        Icons.lock_rounded,
        color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
        size: 18,
      );
    } else {
      backgroundColor = primaryColor.withValues(alpha: 0.1);
      borderColor = iconColor;
      if (progress > 0) {
        child = Text(
          '${(progress * 100).toInt()}%',
          style: GoogleFonts.lexend(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        );
      } else {
        child = Icon(quest.icon, color: iconColor, size: 18);
      }
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: isAvailable
            ? [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isLocked
            ? (isDark ? Colors.grey[900]! : Colors.grey[50]!)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
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
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isLocked
                  ? (isDark ? Colors.grey[600]! : Colors.grey[400]!)
                  : (isDark ? Colors.white : Colors.grey[800]!),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            quest.description,
            style: GoogleFonts.lexend(
              fontSize: 11,
              color: isLocked
                  ? (isDark ? Colors.grey[700]! : Colors.grey[400]!)
                  : Colors.grey[600],
            ),
          ),
          if (!isLocked && progress > 0) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                valueColor: AlwaysStoppedAnimation(iconColor),
                minHeight: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnector(bool isDone, bool isLocked, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(left: 21, top: 4, bottom: 4),
      height: 16,
      width: 2,
      decoration: BoxDecoration(
        color: isDone
            ? AppColors.primary
            : (isLocked
                  ? (isDark ? Colors.grey[800]! : Colors.grey[200]!)
                  : iconColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

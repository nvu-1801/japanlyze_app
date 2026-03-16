import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../roadmap_utils.dart';

/// Widget displaying the overall progress bar with gradient
class OverallProgressBar extends StatelessWidget {
  final Set<String> completedQuestIds;

  const OverallProgressBar({
    super.key,
    required this.completedQuestIds,
  });

  @override
  Widget build(BuildContext context) {
    final totalQuests = RoadmapUtils.getTotalQuestCount();
    final completedCount = RoadmapUtils.getCompletedQuestCount(completedQuestIds);
    final percentage = totalQuests > 0 ? completedCount / totalQuests : 0.0;

    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage.clamp(0.01, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

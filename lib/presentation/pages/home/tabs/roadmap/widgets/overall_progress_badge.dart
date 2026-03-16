import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../domain/entities/roadmap_models.dart';
import '../roadmap_utils.dart';

/// Widget displaying the overall progress badge with percentage and count
class OverallProgressBadge extends StatelessWidget {
  final Set<String> completedQuestIds;
  final bool isLoading;
  final List<RoadmapWeek> weeks;

  const OverallProgressBadge({
    super.key,
    required this.completedQuestIds,
    required this.isLoading,
    required this.weeks,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final totalQuests = RoadmapUtils.getTotalQuestCount(weeks);
    final completedCount = RoadmapUtils.getCompletedQuestCount(completedQuestIds, weeks);
    final percentage = RoadmapUtils.calculateProgress(completedCount, totalQuests);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$percentage%',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: AppColors.primary,
          ),
        ),
        Text(
          '$completedCount/$totalQuests nhiệm vụ',
          style: GoogleFonts.lexend(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

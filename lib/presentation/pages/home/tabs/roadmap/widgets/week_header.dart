import 'package:japalyze/core/constants/app_colors.dart';
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
    final primaryColor = isDark
        ? AppColors.primaryLight
        : AppColors.primaryDark;
    final primaryContainer = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;
    final onPrimary = Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryContainer],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -30,
            bottom: -40,
            child: Opacity(
              opacity: 0.15,
              child: Icon(Icons.translate, size: 120, color: onPrimary),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tuần ${week.week}: ${week.title}',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: onPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                week.description,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: onPrimary.withValues(alpha: 0.8),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}

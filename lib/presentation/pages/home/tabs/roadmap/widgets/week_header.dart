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
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
    final primaryContainer = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final onPrimary = Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryContainer],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -40,
            bottom: -50,
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.translate,
                size: 160,
                color: onPrimary,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tuần ${week.week}: ${week.title}',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: onPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                week.description,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: onPrimary.withValues(alpha: 0.8),
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.group,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'HƠN 1.2K HỌC VIÊN ĐANG HỌC',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget displaying a selectable week tab
class WeekTab extends StatelessWidget {
  final int weekNumber;
  final bool isSelected;
  final Color iconColor;
  final VoidCallback onTap;

  const WeekTab({
    super.key,
    required this.weekNumber,
    required this.isSelected,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? iconColor
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey[200]!),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(
              '$weekNumber',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
            Text(
              'Tuần',
              style: GoogleFonts.lexend(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

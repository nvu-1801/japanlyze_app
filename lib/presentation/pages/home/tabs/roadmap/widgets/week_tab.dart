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
    
    final selectedBg = isDark ? const Color(0xFF5DAC5B) : const Color(0xFF1B6D24);
    final unselectedBg = isDark ? Colors.grey[800] : const Color(0xFFE6E9E7); // surface-container-high
    final selectedText = Colors.white;
    final unselectedText = isDark ? Colors.grey[400] : const Color(0xFF3F4A3C); // on-surface-variant

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          'Tuần $weekNumber',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isSelected ? selectedText : unselectedText,
          ),
        ),
      ),
    );
  }
}

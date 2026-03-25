import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/app_colors.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onQuickVocab;
  final VoidCallback onQuickReading;
  final VoidCallback onQuickExam;

  const QuickActions({
    super.key,
    required this.onQuickVocab,
    required this.onQuickReading,
    required this.onQuickExam,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Luyện tập nhanh',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _ActionCard(
                label: 'Từ vựng',
                icon: Icons.bolt_rounded,
                color: AppColors.primary,
                onTap: onQuickVocab,
              ),
              const SizedBox(width: 12),
              _ActionCard(
                label: 'Luyện đọc',
                icon: Icons.book_rounded,
                color: const Color(0xFFa855f7), // Purple
                onTap: onQuickReading,
              ),
              const SizedBox(width: 12),
              _ActionCard(
                label: 'Thi thử',
                icon: Icons.assignment_rounded,
                color: const Color(0xFFf97316), // Orange
                onTap: onQuickExam,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? color.withOpacity(0.12) : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

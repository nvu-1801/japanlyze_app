import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

/// Skeleton loader for flashcard decks
class DashboardFlashcardDeckSkeleton extends StatelessWidget {
  const DashboardFlashcardDeckSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 160,
      height: 180,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShimmerBox(width: 50, height: 50, borderRadius: 16),
            Spacer(),
            _ShimmerBox(width: 120, height: 14),
            SizedBox(height: 4),
            _ShimmerBox(width: 80, height: 10),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ShimmerEffect(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      ),
    );
  }
}

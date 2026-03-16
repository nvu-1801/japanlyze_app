import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

/// Skeleton loader for exercise cards
class DashboardExerciseCardSkeleton extends StatelessWidget {
  const DashboardExerciseCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ShimmerCircle(size: 50),
            SizedBox(height: 12),
            _ShimmerBox(width: 100, height: 12),
            SizedBox(height: 8),
            _ShimmerBox(width: 80, height: 12),
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

class _ShimmerCircle extends StatelessWidget {
  final double size;

  const _ShimmerCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: ShimmerEffect(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      ),
    );
  }
}

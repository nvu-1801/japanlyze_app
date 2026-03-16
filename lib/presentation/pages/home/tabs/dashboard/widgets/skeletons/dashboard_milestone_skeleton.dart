import 'package:flutter/material.dart';
import '../../../../../../../core/constants/app_colors.dart';
import 'shimmer_effect.dart';

/// Skeleton loader for the milestone card
class DashboardMilestoneSkeleton extends StatelessWidget {
  const DashboardMilestoneSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: _ShimmerBox(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 24,
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

import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

/// Skeleton loader for the stats row
class DashboardStatsSkeleton extends StatelessWidget {
  const DashboardStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < 2 ? 12 : 0),
            child: _ShimmerBox(
              width: double.infinity,
              height: 80,
              borderRadius: 20,
            ),
          ),
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

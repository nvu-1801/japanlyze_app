import 'package:flutter/material.dart';
import 'animated_xp_counter.dart';

/// Modern stats row with animated XP counter
class ModernStatsRow extends StatelessWidget {
  final int xp;
  final int level;
  final int phase;

  const ModernStatsRow({
    super.key,
    required this.xp,
    required this.level,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ModernStatItem(
            icon: Icons.bolt_rounded,
            color: Colors.amber,
            label: 'XP',
            value: xp,
            showAnimation: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: Icons.workspace_premium_rounded,
            color: Colors.blue,
            label: 'Level',
            value: level,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: Icons.flag_rounded,
            color: Colors.green,
            label: 'Phase',
            value: phase,
          ),
        ),
      ],
    );
  }
}

class _ModernStatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int value;
  final bool showAnimation;

  const _ModernStatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.showAnimation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          if (showAnimation)
            AnimatedXpCounter(
              value: value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(
              '$value',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          Text(
            label,
            style: TextStyle(color: Colors.grey[500], fontSize: 10),
          ),
        ],
      ),
    );
  }
}

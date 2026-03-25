import 'package:flutter/material.dart';

/// Modern stats row with animated XP counter
class ModernStatsRow extends StatelessWidget {
  final int streak;
  final String roadmap;
  final bool isPremium;

  const ModernStatsRow({
    super.key,
    required this.streak,
    required this.roadmap,
    required this.isPremium,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ModernStatItem(
            icon: Icons.local_fire_department_rounded,
            color: Colors.orange,
            label: 'Streak',
            value: '$streak',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: Icons.map_rounded,
            color: Colors.blue,
            label: 'Roadmap',
            value: roadmap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: isPremium
                ? Icons.workspace_premium_rounded
                : Icons.person_rounded,
            color: isPremium ? Colors.amber : Colors.green,
            label: isPremium ? 'Premium' : 'Sử dụng',
            value: isPremium ? 'VIP' : 'Basic',
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
  final String value;

  const _ModernStatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 9)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../domain/entities/roadmap_models.dart';
import '../roadmap_utils.dart';

/// Widget displaying a quest card with status and navigation
class QuestCard extends StatefulWidget {
  final RoadmapQuest quest;
  final RoadmapWeek week;
  final Set<String> completedQuestIds;
  final double progress; // 0.0 to 1.0
  final VoidCallback onTap;

  const QuestCard({
    super.key,
    required this.quest,
    required this.week,
    required this.completedQuestIds,
    required this.onTap,
    this.progress = 0.0,
  });

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDone = widget.completedQuestIds.contains(widget.quest.id);
    final isLocked = RoadmapUtils.isQuestLocked(widget.quest, widget.completedQuestIds);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        if (!isLocked) {
          HapticFeedback.lightImpact();
        }
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isLocked
                ? (isDark ? Colors.grey[900] : Colors.grey[50])
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDone
                  ? Colors.green.withValues(alpha: 0.3)
                  : (isDark ? Colors.grey[800]! : Colors.grey[100]!),
              width: 1,
            ),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isLocked
                            ? (isDark ? Colors.grey[800] : Colors.grey[200])
                            : widget.week.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        isLocked ? Icons.lock_rounded : widget.quest.icon,
                        color: isLocked
                            ? (isDark ? Colors.grey[600] : Colors.grey[400])
                            : widget.week.iconColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.quest.title,
                            style: GoogleFonts.lexend(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isLocked
                                  ? (isDark
                                        ? Colors.grey[600]
                                        : Colors.grey[400])
                                  : (isDark ? Colors.white : Colors.grey[800]),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                isLocked
                                    ? 'Đang khóa'
                                    : (isDone
                                          ? 'Đã hoàn thành'
                                          : 'Sẵn sàng học'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isLocked
                                      ? (isDark
                                            ? Colors.grey[700]
                                            : Colors.grey[400])
                                      : (isDone
                                            ? Colors.green
                                            : Colors.grey[500]),
                                  fontWeight: isDone
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              if (!isLocked && widget.progress > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.week.color.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${(widget.progress * 100).toInt()}%',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: widget.week.iconColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isLocked)
                      Icon(
                        Icons.lock_outline_rounded,
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        size: 20,
                      )
                    else if (isDone)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 22,
                      )
                    else
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        size: 22,
                      ),
                  ],
                ),
                if (!isLocked && !isDone && widget.progress > 0) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: widget.progress,
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : Colors.grey[100],
                      valueColor: AlwaysStoppedAnimation(widget.week.iconColor),
                      minHeight: 6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../domain/entities/conversation_models.dart';

class ExerciseCard extends StatefulWidget {
  final LessonItem lesson;
  final bool isLocked;
  final bool isCompleted;
  final double progress; // 0.0 to 1.0
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.lesson,
    required this.onTap,
    this.isLocked = false,
    this.isCompleted = false,
    this.progress = 0.0,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        if (!widget.isLocked) {
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
            color: widget.isLocked
                ? (isDark ? Colors.grey[900] : Colors.grey[50])
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isCompleted
                  ? Colors.green.withValues(alpha: 0.3)
                  : (isDark ? Colors.grey[800]! : Colors.grey[100]!),
              width: 1,
            ),
            boxShadow: [
              if (!widget.isLocked)
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
                        color: widget.isLocked
                            ? (isDark ? Colors.grey[800] : Colors.grey[200])
                            : (widget.lesson.backgroundColor ??
                                  widget.lesson.color.withValues(alpha: 0.1)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        widget.isLocked
                            ? Icons.lock_rounded
                            : widget.lesson.icon,
                        color: widget.isLocked
                            ? (isDark ? Colors.grey[600] : Colors.grey[400])
                            : widget.lesson.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lesson.title,
                            style: GoogleFonts.lexend(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: widget.isLocked
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
                                widget.isLocked
                                    ? 'Đang khóa'
                                    : (widget.isCompleted
                                          ? 'Đã hoàn thành'
                                          : 'Sẵn sàng luyện tập'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.isLocked
                                      ? (isDark
                                            ? Colors.grey[700]
                                            : Colors.grey[400])
                                      : (widget.isCompleted
                                            ? Colors.green
                                            : Colors.grey[500]),
                                  fontWeight: widget.isCompleted
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              if (!widget.isLocked && widget.progress > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.lesson.color.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${(widget.progress * 100).toInt()}%',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: widget.lesson.color,
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
                    if (widget.isLocked)
                      Icon(
                        Icons.lock_outline_rounded,
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        size: 20,
                      )
                    else if (widget.isCompleted)
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
                if (!widget.isLocked &&
                    !widget.isCompleted &&
                    widget.progress > 0) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: widget.progress,
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : Colors.grey[100],
                      valueColor: AlwaysStoppedAnimation(widget.lesson.color),
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

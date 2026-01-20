import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../domain/entities/conversation_models.dart';

class ExerciseCard extends StatefulWidget {
  final LessonItem lesson;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.lesson,
    required this.onTap,
    this.isLocked = false,
    this.isCompleted = false,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // If locked, we might want to disable the press animation or change it
    // But usually we still want to tap it to show the locked dialog.
    
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
                ? Colors.grey[50] 
                : (widget.isCompleted ? Colors.green.shade50.withOpacity(0.5) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isCompleted ? Colors.green.shade200 : Colors.grey.shade200,
            ),
            boxShadow: [
              if (!widget.isLocked)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.isLocked 
                        ? Colors.grey[200] 
                        : (widget.lesson.backgroundColor ?? widget.lesson.color.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.isLocked ? Icons.lock : widget.lesson.icon,
                    color: widget.isLocked ? Colors.grey[400] : widget.lesson.color,
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: widget.isLocked ? Colors.grey[400] : Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.isLocked 
                            ? 'Đang khóa' 
                            : (widget.isCompleted ? 'Đã hoàn thành' : 'Sẵn sàng'),
                        style: TextStyle(
                          fontSize: 13,
                          color: widget.isLocked 
                              ? Colors.grey[400] 
                              : (widget.isCompleted ? Colors.green : Colors.grey[500]),
                          fontWeight: widget.isCompleted ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isLocked)
                  Icon(
                    Icons.lock_outline,
                    color: Colors.grey[300],
                    size: 20,
                  )
                else if (widget.isCompleted)
                  Icon(
                    Icons.check_circle,
                    color: Colors.green[500],
                    size: 20,
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[300],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

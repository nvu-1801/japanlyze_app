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
  final List<RoadmapWeek> weeks;

  const QuestCard({
    super.key,
    required this.quest,
    required this.week,
    required this.completedQuestIds,
    required this.onTap,
    this.progress = 0.0,
    required this.weeks,
  });

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDone = widget.completedQuestIds.contains(widget.quest.id);
    final isLocked = RoadmapUtils.isQuestLocked(widget.quest, widget.completedQuestIds, widget.weeks);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = isDark ? const Color(0xFF5DAC5B) : const Color(0xFF1B6D24);
    final primaryFixedColor = isDark ? const Color(0xFF1B6D24) : const Color(0xFFA3F69C);
    
    Color bgColor = isDark ? Colors.grey[850]! : Colors.white;
    Color borderColor = primaryColor.withOpacity(0.2);
    Color iconBgColor = primaryFixedColor;
    Color iconColor = isDark ? Colors.white : primaryColor;
    Color titleColor = isDark ? Colors.white : const Color(0xFF191C1B);
    Color subtitleColor = isDark ? Colors.grey[400]! : const Color(0xFF3F4A3C);
    
    if (isLocked) {
      bgColor = isDark ? Colors.grey[900]! : const Color(0xFFF2F4F2).withOpacity(0.5);
      borderColor = Colors.transparent;
      iconBgColor = isDark ? Colors.grey[800]! : const Color(0xFFE1E3E1);
      iconColor = isDark ? Colors.grey[500]! : const Color(0xFF3F4A3C);
      titleColor = isDark ? Colors.grey[500]! : const Color(0xFF3F4A3C);
      subtitleColor = titleColor.withOpacity(0.6);
    } else if (isDone) {
      bgColor = isDark ? Colors.grey[850]! : const Color(0xFFF8FAF8);
      borderColor = isDark ? Colors.grey[800]! : const Color(0xFFBECAB9).withOpacity(0.5);
      iconBgColor = isDark ? Colors.green[900]!.withOpacity(0.3) : Colors.green[50]!;
      iconColor = isDark ? Colors.green[400]! : Colors.green[700]!;
      titleColor = isDark ? Colors.grey[300]! : const Color(0xFF191C1B).withOpacity(0.8);
      subtitleColor = isDark ? Colors.grey[500]! : const Color(0xFF3F4A3C).withOpacity(0.8);
    }

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
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: (!isLocked && !isDone)
                ? [
                    BoxShadow(
                      color: const Color(0xFF191C1B).withOpacity(0.04),
                      blurRadius: 32,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.quest.icon,
                          color: iconColor,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.quest.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getSubtitleForQuest(widget.quest),
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: subtitleColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (!isLocked && !isDone && widget.progress > 0) ...[
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: widget.progress,
                                backgroundColor: isDark
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation(primaryColor),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (isLocked)
                Icon(
                  Icons.lock_rounded,
                  color: isDark ? Colors.grey[700] : const Color(0xFF3F4A3C).withOpacity(0.4),
                  size: 24,
                )
              else if (isDone)
                Icon(
                  Icons.check_circle_rounded,
                  color: iconColor,
                  size: 28,
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BẮT ĐẦU',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: primaryColor,
                      size: 24,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSubtitleForQuest(RoadmapQuest quest) {
    switch (quest.type) {
      case 'conversation':
        return 'Hội thoại giao tiếp';
      case 'flashcard':
        return 'Thẻ nhớ từ vựng';
      case 'grammar':
        return 'Ngữ pháp cơ bản';
      case 'kanji':
        return 'Hán tự cốt lõi';
      case 'exam':
        return 'Kiểm tra năng lực';
      default:
        return 'Nhiệm vụ học tập';
    }
  }
}

import 'package:japalyze/core/constants/app_colors.dart';
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
    final isLocked = RoadmapUtils.isQuestLocked(
      widget.quest,
      widget.completedQuestIds,
      widget.weeks,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = isDark
        ? AppColors.primaryLight
        : AppColors.primaryDark;
    final primaryFixedColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;

    Color bgColor = isDark ? Colors.grey[850]! : Colors.white;
    Color borderColor = primaryColor.withValues(alpha: 0.2);
    Color iconBgColor = primaryFixedColor;
    Color iconColor = isDark ? Colors.white : primaryColor;
    Color titleColor = isDark ? Colors.white : AppColors.textPrimary;
    Color subtitleColor = isDark ? Colors.grey[400]! : AppColors.textSecondary;

    if (isLocked) {
      bgColor = isDark
          ? Colors.grey[900]!
          : AppColors.background.withValues(alpha: 0.5);
      borderColor = Colors.transparent;
      iconBgColor = isDark ? Colors.grey[800]! : const Color(0xFFE1E3E1);
      iconColor = isDark ? Colors.grey[500]! : AppColors.textSecondary;
      titleColor = isDark ? Colors.grey[500]! : AppColors.textSecondary;
      subtitleColor = titleColor.withValues(alpha: 0.6);
    } else if (isDone) {
      bgColor = isDark ? Colors.grey[850]! : AppColors.background;
      borderColor = isDark
          ? Colors.grey[800]!
          : AppColors.primary.withValues(alpha: 0.5);
      iconBgColor = isDark
          ? AppColors.primaryDark.withValues(alpha: 0.3)
          : AppColors.primaryLight.withValues(alpha: 0.1);
      iconColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
      titleColor = isDark
          ? Colors.grey[300]!
          : AppColors.textPrimary.withValues(alpha: 0.8);
      subtitleColor = isDark
          ? Colors.grey[500]!
          : AppColors.textSecondary.withValues(alpha: 0.8);
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
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: (!isLocked && !isDone)
                ? [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.quest.icon,
                          color: iconColor,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.quest.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _getSubtitleForQuest(widget.quest),
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: subtitleColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (!isLocked && !isDone && widget.progress > 0) ...[
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: widget.progress,
                                backgroundColor: isDark
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation(
                                  primaryColor,
                                ),
                                minHeight: 3,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (isLocked)
                Icon(
                  Icons.lock_rounded,
                  color: isDark
                      ? Colors.grey[700]
                      : AppColors.textSecondary.withValues(alpha: 0.4),
                  size: 20,
                )
              else if (isDone)
                Icon(Icons.check_circle_rounded, color: iconColor, size: 24)
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BẮT ĐẦU',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: primaryColor,
                      size: 20,
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

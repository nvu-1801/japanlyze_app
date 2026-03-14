import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../data/services/user_progress_service.dart';

class ConversationLessonPage extends StatelessWidget {
  final ConversationLesson lesson;
  final String? questId;

  const ConversationLessonPage({super.key, required this.lesson, this.questId});

  Future<void> _completeLesson(BuildContext context) async {
    await UserProgressService().markMultipleAsCompleted([questId, lesson.id]);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          lesson.title,
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: isDark ? Colors.white : AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      body: lesson.vocabItems.isNotEmpty
          ? _buildVocabList(context)
          : _buildDialogueList(context),
    );
  }

  // ─── Vocab List (Nhập môn / Từ vựng) ───────────────────────────────────────

  Widget _buildVocabList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: lesson.vocabItems.length + 1,
      itemBuilder: (context, index) {
        if (index == lesson.vocabItems.length) {
          return _buildCompletionButton(context);
        }
        return _VocabCard(item: lesson.vocabItems[index]);
      },
    );
  }

  // ─── Dialogue List (Hội thoại) ──────────────────────────────────────────────

  Widget _buildDialogueList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: lesson.lines.length + 1,
      itemBuilder: (context, index) {
        if (index == lesson.lines.length) {
          return _buildCompletionButton(context);
        }
        return _DialogueCard(line: lesson.lines[index]);
      },
    );
  }

  // ─── Completion Button ──────────────────────────────────────────────────────

  Widget _buildCompletionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: FilledButton.icon(
        onPressed: () => _completeLesson(context),
        icon: const Icon(Icons.check_circle_rounded, size: 22),
        label: Text(
          'Hoàn thành bài học',
          style: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Vocab Card — used for Hiragana, Katakana, vocabulary topics
// ═══════════════════════════════════════════════════════════════════════════════

class _VocabCard extends StatelessWidget {
  final VocabItem item;

  const _VocabCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Japanese character showcase
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  item.kanji.isNotEmpty ? item.kanji : item.kana,
                  style: GoogleFonts.notoSansJp(
                    fontSize: item.kanji.length <= 2 ? 26 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kana reading
                  Text(
                    item.kana,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  if (item.romaji.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.romaji,
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.grey[500],
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  // Meaning
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.meaning,
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Dialogue Card — used for conversation lessons
// ═══════════════════════════════════════════════════════════════════════════════

class _DialogueCard extends StatefulWidget {
  final DialogueLine line;

  const _DialogueCard({required this.line});

  @override
  State<_DialogueCard> createState() => _DialogueCardState();
}

class _DialogueCardState extends State<_DialogueCard> {
  bool _answered = false;
  int? _selectedIndex;

  Widget _buildFuriganaText(List<Segment> segments, bool isDark) {
    return Wrap(
      spacing: 2,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: segments.map((segment) {
        if (segment.furigana == null) {
          return Text(
            segment.text,
            style: GoogleFonts.notoSansJp(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              segment.furigana!,
              style: GoogleFonts.notoSansJp(
                fontSize: 10,
                color: isDark ? Colors.white70 : Colors.grey[600],
              ),
            ),
            Text(
              segment.text,
              style: GoogleFonts.notoSansJp(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _handleOptionTap(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final line = widget.line;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Speaker + Quiz badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    line.speaker.name.toUpperCase(),
                    style: GoogleFonts.lexend(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (line.isQuiz) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'QUIZ',
                      style: GoogleFonts.lexend(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            if (line.isQuiz && line.quizQuestion != null) ...[
              // Quiz Question
              _buildFuriganaText(line.quizQuestion!, isDark),
              const SizedBox(height: 16),
              // Quiz Options
              if (line.quizOptions != null)
                ...line.quizOptions!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final text = entry.value;

                  bool isSelected = _selectedIndex == index;
                  bool isCorrectAnswer = index == line.correctOptionIndex;

                  Color? bgColor;
                  Color? borderColor;
                  Color textColor = isDark
                      ? Colors.white
                      : AppColors.textPrimary;

                  if (_answered) {
                    if (isCorrectAnswer) {
                      bgColor = Colors.green.withValues(alpha: 0.15);
                      borderColor = Colors.green;
                      textColor = Colors.green[700]!;
                    } else if (isSelected) {
                      bgColor = Colors.red.withValues(alpha: 0.15);
                      borderColor = Colors.red;
                      textColor = Colors.red[700]!;
                    } else {
                      bgColor = isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey[50];
                      borderColor = isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey[200];
                      textColor = isDark ? Colors.white54 : Colors.grey[500]!;
                    }
                  } else {
                    bgColor = isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.white;
                    borderColor = isDark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.grey[300];
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _handleOptionTap(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Ink(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: borderColor ?? Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  text,
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    color: textColor,
                                    fontWeight:
                                        (_answered &&
                                            (isCorrectAnswer || isSelected))
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (_answered && isCorrectAnswer)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                )
                              else if (_answered && isSelected)
                                const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

              if (_answered) ...[
                const SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                ),
                const SizedBox(height: 10),
                Text(
                  line.meaning,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey[700],
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ],
            ] else ...[
              // Normal Dialogue Japanese text
              Text(
                line.kana,
                style: GoogleFonts.notoSansJp(
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  height: 1.6,
                ),
              ),
              if (line.romaji.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  line.romaji,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.grey[500],
                    letterSpacing: 0.3,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              // Divider
              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.06),
              ),
              const SizedBox(height: 10),
              // Vietnamese meaning
              Text(
                line.meaning,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.grey[700],
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

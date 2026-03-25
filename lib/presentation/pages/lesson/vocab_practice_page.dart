import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/conversation_models.dart';
import '../../../data/services/user_progress_service.dart';

enum QuestionType { mcqKanjiToMeaning, mcqMeaningToKana, typingMeaningToRomaji }

class VocabQuestion {
  final VocabItem item;
  final QuestionType type;
  final List<String>? options;
  final String correctAnswer;

  VocabQuestion({
    required this.item,
    required this.type,
    this.options,
    required this.correctAnswer,
  });
}

class VocabPracticePage extends StatefulWidget {
  final ConversationLesson lesson;
  final String? questId;

  const VocabPracticePage({super.key, required this.lesson, this.questId});

  @override
  State<VocabPracticePage> createState() => _VocabPracticePageState();
}

class _VocabPracticePageState extends State<VocabPracticePage> {
  final Random _random = Random();
  late List<VocabQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;

  // State for current question
  bool _answered = false;
  bool _isCorrect = false;
  String? _selectedOption;
  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    final vocabList = List<VocabItem>.from(widget.lesson.vocabItems);
    vocabList.shuffle(_random);
    final selectedVocabs = vocabList.take(10).toList();

    _questions = selectedVocabs.map((vocab) {
      // Pick random question type
      // 0: mcqKanjiToMeaning, 1: mcqMeaningToKana, 2: typingMeaningToRomaji
      int typeIdx = _random.nextInt(3);
      if (typeIdx == 2 && vocab.romaji.isEmpty) {
        typeIdx = 0; // Fallback if no romaji
      }

      final type = QuestionType.values[typeIdx];

      if (type == QuestionType.mcqKanjiToMeaning) {
        final answer = vocab.meaning;
        final wrongOptions =
            vocabList
                .where((v) => v.meaning != answer)
                .map((v) => v.meaning)
                .toList()
              ..shuffle(_random);
        final options = [answer, ...wrongOptions.take(3)]..shuffle(_random);
        return VocabQuestion(
          item: vocab,
          type: type,
          options: options,
          correctAnswer: answer,
        );
      } else if (type == QuestionType.mcqMeaningToKana) {
        final displayKana = vocab.kanji.isNotEmpty ? vocab.kanji : vocab.kana;
        final answer = displayKana;
        final wrongOptions =
            vocabList
                .where((v) => (v.kanji.isNotEmpty ? v.kanji : v.kana) != answer)
                .map((v) => v.kanji.isNotEmpty ? v.kanji : v.kana)
                .toList()
              ..shuffle(_random);
        final options = [answer, ...wrongOptions.take(3)]..shuffle(_random);
        return VocabQuestion(
          item: vocab,
          type: type,
          options: options,
          correctAnswer: answer,
        );
      } else {
        // Typing
        return VocabQuestion(
          item: vocab,
          type: type,
          correctAnswer: vocab.romaji.toLowerCase(),
        );
      }
    }).toList();
  }

  void _submitAnswer() {
    final currentQ = _questions[_currentIndex];

    setState(() {
      _answered = true;
      if (currentQ.type == QuestionType.typingMeaningToRomaji) {
        final userInput = _typeController.text.trim().toLowerCase();
        // Allow tiny typos or Kana vs Romaji if needed, but strict romaji for now
        _isCorrect =
            userInput == currentQ.correctAnswer ||
            userInput == currentQ.item.kana;
      } else {
        _isCorrect = _selectedOption == currentQ.correctAnswer;
      }

      if (_isCorrect) _score++;
    });

    // Update progress
    _updateProgress();

    // Auto next after delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _answered = false;
          _isCorrect = false;
          _selectedOption = null;
          _typeController.clear();
        });
      } else {
        _showSummary();
      }
    });
  }

  void _updateProgress() {
    final total = _questions.length;
    if (total > 0 && widget.questId != null) {
      final progress = (_currentIndex + 1) / total;
      UserProgressService().updateQuestProgress(widget.questId!, progress);
    }
  }

  Future<void> _showSummary() async {
    final total = _questions.length;

    // Mark completed when finished (score independent for testing)
    await UserProgressService().markMultipleAsCompleted([
      widget.questId,
      widget.lesson.id,
    ]);

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _score >= total / 2
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _score >= total / 2
                    ? Icons.emoji_events_rounded
                    : Icons.sentiment_satisfied_rounded,
                color: _score >= total / 2 ? Colors.green : Colors.orange,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _score >= total / 2 ? 'Tuyệt vời! 🎉' : 'Cố gắng lên nhé! 💪',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bạn làm đúng $_score/$total câu hỏi.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _generateQuestions();
                        _currentIndex = 0;
                        _score = 0;
                        _answered = false;
                        _isCorrect = false;
                        _selectedOption = null;
                        _typeController.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Thử lại'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context, true); // Close quiz
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Hoàn thành'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) return const Scaffold();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentQ = _questions[_currentIndex];
    final total = _questions.length;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close_rounded,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / total,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 6,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Câu ${_currentIndex + 1}/$total',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildQuestionPrompt(currentQ, isDark),
                      const SizedBox(height: 40),
                      if (currentQ.type == QuestionType.typingMeaningToRomaji)
                        _buildTypingInput(currentQ)
                      else
                        _buildMCQOptions(currentQ, isDark),
                    ],
                  ),
                ),
              ),
              if (_answered) _buildFeedbackBanner(),
              if (!_answered &&
                  currentQ.type == QuestionType.typingMeaningToRomaji)
                ElevatedButton(
                  onPressed: _typeController.text.trim().isNotEmpty
                      ? _submitAnswer
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[500],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Kiểm tra',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPrompt(VocabQuestion q, bool isDark) {
    String promptText = '';
    String subText = '';

    if (q.type == QuestionType.mcqKanjiToMeaning) {
      promptText = q.item.kanji.isNotEmpty ? q.item.kanji : q.item.kana;
      subText = q.item.kanji.isNotEmpty ? q.item.kana : '';
    } else if (q.type == QuestionType.mcqMeaningToKana ||
        q.type == QuestionType.typingMeaningToRomaji) {
      promptText = q.item.meaning;
    }

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            q.type == QuestionType.typingMeaningToRomaji
                ? 'Gõ Romaji hoặc Kana cho từ này'
                : 'Chọn đáp án đúng',
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          const SizedBox(height: 16),
          Text(
            promptText,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansJp(
              fontSize: q.type == QuestionType.mcqKanjiToMeaning ? 48 : 28,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          if (subText.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              subText,
              style: TextStyle(color: Colors.grey[500], fontSize: 20),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMCQOptions(VocabQuestion q, bool isDark) {
    return Column(
      children: q.options!.map((opt) {
        bool isSelected = _selectedOption == opt;
        bool isCorrectOpt = opt == q.correctAnswer;

        Color bgColor = isDark ? Colors.grey[800]! : Colors.white;
        Color borderColor = Colors.grey.withValues(alpha: 0.2);
        Color textColor = isDark ? Colors.white : AppColors.textPrimary;

        if (_answered) {
          if (isCorrectOpt) {
            bgColor = Colors.green.withValues(alpha: 0.1);
            borderColor = Colors.green;
            textColor = Colors.green;
          } else if (isSelected && !isCorrectOpt) {
            bgColor = Colors.red.withValues(alpha: 0.1);
            borderColor = Colors.red;
            textColor = Colors.red;
          }
        } else if (isSelected) {
          bgColor = AppColors.primary.withValues(alpha: 0.1);
          borderColor = AppColors.primary;
          textColor = AppColors.primary;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: _answered
                ? null
                : () {
                    setState(() {
                      _selectedOption = opt;
                    });
                    _submitAnswer();
                  },
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Center(
                child: Text(
                  opt,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypingInput(VocabQuestion q) {
    return TextField(
      controller: _typeController,
      enabled: !_answered,
      autofocus: true,
      textAlign: TextAlign.center,
      style: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Nhập câu trả lời...',
        filled: true,
        fillColor: Theme.of(context).cardColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      onChanged: (val) {
        setState(() {}); // refresh button state
      },
      onSubmitted: (val) {
        if (val.trim().isNotEmpty && !_answered) {
          _submitAnswer();
        }
      },
    );
  }

  Widget _buildFeedbackBanner() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isCorrect
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _isCorrect ? Colors.green : Colors.red),
      ),
      child: Row(
        children: [
          Icon(
            _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: _isCorrect ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isCorrect
                  ? 'Chính xác!'
                  : 'Chưa đúng. Đáp án là: ${_questions[_currentIndex].correctAnswer}',
              style: TextStyle(
                color: _isCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

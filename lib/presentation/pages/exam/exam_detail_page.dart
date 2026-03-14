import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/exam.dart';
import '../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../domain/entities/test_result.dart';
import '../../../injection_container.dart';
import '../../blocs/auth/auth_bloc.dart';

class ExamDetailPage extends StatefulWidget {
  final String examId;
  final String title;

  const ExamDetailPage({super.key, required this.examId, required this.title});

  @override
  State<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends State<ExamDetailPage> {
  final ExamRemoteDataSource _dataSource = sl<ExamRemoteDataSource>();
  Exam? _exam;
  bool _isLoading = true;
  String? _error;

  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _isFinished = false;

  // Timer state
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _fetchExamDetail();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchExamDetail() async {
    try {
      final exam = await _dataSource.getExamDetail(widget.examId);
      if (mounted) {
        setState(() {
          _exam = exam;
          _isLoading = false;
          _remainingSeconds = exam.duration * 60;
        });
        _startTimer();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Không thể tải nội dung đề thi.';
          _isLoading = false;
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _finishExam();
      }
    });
  }

  String _formatTime(int seconds) {
    final mins = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _finishExam() async {
    _timer?.cancel();
    final score = _calculateScore();
    final total = _exam?.questions?.length ?? 0;

    // Map answers with question IDs for Prisma compatibility
    final mappedAnswers = <String, int>{};
    if (_exam?.questions != null) {
      _selectedAnswers.forEach((index, answerIndex) {
        if (index < _exam!.questions!.length) {
          mappedAnswers[_exam!.questions![index].id] = answerIndex;
        }
      });
    }

    // Save result if user is authenticated
    final authState = context.read<AuthBloc>().state;
    debugPrint('DEBUG: _finishExam - authState: ${authState.runtimeType}');

    if (authState is AuthAuthenticated) {
      debugPrint('DEBUG: User authenticated: ${authState.user.uuid}');
      final result = TestResult(
        uuid: const Uuid().v4(),
        score: score,
        totalQuestions: total,
        completedAt: DateTime.now(),
        userId: authState.user.uuid,
        testId: widget.examId,
        answers: jsonEncode(mappedAnswers),
      );

      debugPrint('DEBUG: Attempting to save result: ${result.toJson()}');
      try {
        await _dataSource.saveTestResult(result);
        debugPrint('DEBUG: Result saved successfully');
      } catch (e) {
        debugPrint('DEBUG: Failed to save result: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Không thể lưu kết quả thi: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      debugPrint('DEBUG: User not authenticated, skip saving');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bạn cần đăng nhập để lưu lịch sử thi.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isFinished = true);
    }
  }

  int _calculateScore() {
    if (_exam?.questions == null) return 0;
    int correct = 0;
    for (int i = 0; i < _exam!.questions!.length; i++) {
      if (_selectedAnswers[i] == _exam!.questions![i].correctAnswer) {
        correct++;
      }
    }
    return correct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          _isFinished ? 'Kết quả' : widget.title,
          style: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          if (!_isFinished && _exam != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _remainingSeconds < 300
                        ? Colors.red.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: _remainingSeconds < 300
                            ? Colors.red
                            : AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.bold,
                          color: _remainingSeconds < 300
                              ? Colors.red
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : _error != null
          ? _buildErrorView()
          : _isFinished
          ? _buildResultView()
          : _buildQuizView(),
    );
  }

  Widget _buildQuizView() {
    if (_exam?.questions == null || _exam!.questions!.isEmpty) {
      return const Center(child: Text('Đề thi này chưa có câu hỏi.'));
    }

    final question = _exam!.questions![_currentIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: (_currentIndex + 1) / _exam!.questions!.length,
          backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          minHeight: 4,
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Number
                Text(
                  'Câu ${_currentIndex + 1} / ${_exam!.questions!.length}',
                  style: GoogleFonts.lexend(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),

                // Question Content
                Text(
                  question.content,
                  style: GoogleFonts.notoSansJp(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Options
                ...List.generate(question.options.length, (index) {
                  final option = question.options[index];
                  final isSelected = _selectedAnswers[_currentIndex] == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAnswers[_currentIndex] = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : isDark
                              ? Colors.white10
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : isDark
                                    ? Colors.white38
                                    : Colors.grey[400]!,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index),
                                style: GoogleFonts.lexend(
                                  color: isSelected
                                      ? Colors.white
                                      : isDark
                                      ? Colors.white
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: GoogleFonts.notoSansJp(
                                fontSize: 16,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Navigation buttons
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: BoxDecoration(
            color: isDark ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              if (_currentIndex > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _currentIndex--),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text('Câu trước', style: GoogleFonts.lexend()),
                  ),
                ),
              if (_currentIndex > 0) const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (_currentIndex < _exam!.questions!.length - 1) {
                      setState(() => _currentIndex++);
                    } else {
                      _showFinishConfirmation();
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _currentIndex < _exam!.questions!.length - 1
                        ? 'Tiếp theo'
                        : 'Nộp bài',
                    style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFinishConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Nộp bài?',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Bạn đã làm ${_selectedAnswers.length} / ${_exam!.questions!.length} câu. Bạn có muốn kết thúc bài thi không?',
          style: GoogleFonts.lexend(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Để sau', style: GoogleFonts.lexend()),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _finishExam();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Nộp bài', style: GoogleFonts.lexend()),
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    final score = _calculateScore();
    final total = _exam!.questions!.length;
    final percentage = (score / total * 100).toInt();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Score summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: percentage >= 50
                    ? [AppColors.primary, AppColors.primaryDark]
                    : [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  percentage >= 50 ? 'Chúc mừng!' : 'Cố gắng lên!',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: score / total,
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '$score/$total',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Câu đúng',
                          style: GoogleFonts.lexend(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Text(
            'Chi tiết đáp án',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Question summary list
          ...List.generate(_exam!.questions!.length, (index) {
            final q = _exam!.questions![index];
            final userAnswer = _selectedAnswers[index];
            final isCorrect = userAnswer == q.correctAnswer;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCorrect
                      ? Colors.green.withValues(alpha: 0.3)
                      : Colors.red.withValues(alpha: 0.3),
                ),
              ),
              child: ExpansionTile(
                leading: Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
                title: Text(
                  'Câu ${index + 1}',
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  isCorrect ? 'Đúng' : 'Sai',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          q.content,
                          style: GoogleFonts.notoSansJp(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Đáp án: ${q.options[q.correctAnswer]}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!isCorrect)
                          Text(
                            'Bạn chọn: ${userAnswer != null ? q.options[userAnswer] : "Chưa trả lời"}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        if (q.explanation != null) ...[
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'Giải thích:',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            q.explanation!,
                            style: GoogleFonts.lexend(
                              fontSize: 13,
                              color: isDark ? Colors.white70 : Colors.grey[700],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Trở về',
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 48, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _fetchExamDetail();
              },
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}

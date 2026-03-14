import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/test_result.dart';
import '../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../injection_container.dart';

class ExamResultDetailPage extends StatefulWidget {
  final TestResult result;
  final String title;

  const ExamResultDetailPage({
    super.key,
    required this.result,
    required this.title,
  });

  @override
  State<ExamResultDetailPage> createState() => _ExamResultDetailPageState();
}

class _ExamResultDetailPageState extends State<ExamResultDetailPage> {
  final ExamRemoteDataSource _dataSource = sl<ExamRemoteDataSource>();
  Exam? _exam;
  bool _isLoading = true;
  String? _error;
  Map<int, int> _mappedAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadExamDetail();
  }

  Future<void> _loadExamDetail() async {
    try {
      final exam = await _dataSource.getExamDetail(widget.result.testId);

      // Map JSON answers back to indices
      final answersMap = <int, int>{};
      final decoded = jsonDecode(widget.result.answers) as Map<String, dynamic>;

      if (exam.questions != null) {
        for (int i = 0; i < exam.questions!.length; i++) {
          final qId = exam.questions![i].id;
          if (decoded.containsKey(qId)) {
            answersMap[i] = decoded[qId] as int;
          }
        }
      }

      if (mounted) {
        setState(() {
          _exam = exam;
          _mappedAnswers = answersMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Không thể tải chi tiết đề thi.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Chi tiết bài làm',
          style: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : _error != null
          ? _buildErrorView()
          : _buildResultContent(isDark),
    );
  }

  Widget _buildResultContent(bool isDark) {
    final score = widget.result.score;
    final total = widget.result.totalQuestions;
    final percentage = (score / total * 100).toInt();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Score Card (Reuse style from ExamDetailPage)
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
            ),
            child: Column(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansJp(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$score / $total câu đúng',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tỉ lệ chính xác: $percentage%',
                  style: GoogleFonts.lexend(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Question List
          ...List.generate(_exam!.questions!.length, (index) {
            final q = _exam!.questions![index];
            final userAnswer = _mappedAnswers[index];
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
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
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
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildOptionRow(
                          'Đáp án đúng:',
                          q.options[q.correctAnswer],
                          Colors.green,
                        ),
                        if (!isCorrect)
                          _buildOptionRow(
                            'Bạn đã chọn:',
                            userAnswer != null
                                ? q.options[userAnswer]
                                : "Chưa trả lời",
                            Colors.red,
                          ),
                        if (q.explanation != null) ...[
                          const SizedBox(height: 12),
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
        ],
      ),
    );
  }

  Widget _buildOptionRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.notoSansJp(
                fontSize: 13,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error ?? 'Lỗi không xác định'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() => _isLoading = true);
              _loadExamDetail();
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}

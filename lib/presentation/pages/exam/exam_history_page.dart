import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/entities/exam.dart';
import '../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../injection_container.dart';
import 'exam_result_page.dart';
import '../../blocs/auth/auth_bloc.dart';

class ExamHistoryPage extends StatefulWidget {
  const ExamHistoryPage({super.key});

  @override
  State<ExamHistoryPage> createState() => _ExamHistoryPageState();
}

class _ExamHistoryPageState extends State<ExamHistoryPage> {
  final ExamRemoteDataSource _dataSource = sl<ExamRemoteDataSource>();
  List<TestResult> _history = [];
  Map<String, Exam> _examMap = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final history = await _dataSource.getTestHistory(authState.user.uuid);

      // Load exam details for titles if we have exams
      final exams = await _dataSource.getExams();
      final map = {for (var e in exams) e.id: e};

      if (mounted) {
        setState(() {
          _history = history;
          _examMap = map;
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
          'Lịch sử thi',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : _history.isEmpty
          ? _buildEmptyState(isDark)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final result = _history[index];
                final exam = _examMap[result.testId];
                return _HistoryCard(result: result, exam: exam);
              },
            ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 64,
            color: isDark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.05),
          ),
          const SizedBox(height: 16),
          Text(
            'Bạn chưa có lịch sử thi nào.',
            style: GoogleFonts.lexend(
              color: isDark ? Colors.white54 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final TestResult result;
  final Exam? exam;

  const _HistoryCard({required this.result, this.exam});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final percentage = (result.score / result.totalQuestions * 100).toInt();
    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(result.completedAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExamResultDetailPage(
                    result: result,
                    title: exam?.title ?? 'Đề thi đã bị xóa',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (percentage >= 50 ? Colors.green : Colors.orange)
                          .withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: percentage >= 50
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exam?.title ?? 'Đề thi đã bị xóa',
                          style: GoogleFonts.notoSansJp(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              size: 12,
                              color: isDark ? Colors.white38 : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${result.score}/${result.totalQuestions} câu đúng',
                              style: GoogleFonts.lexend(
                                fontSize: 11,
                                color: isDark ? Colors.white38 : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: isDark ? Colors.white38 : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dateStr,
                              style: GoogleFonts.lexend(
                                fontSize: 11,
                                color: isDark ? Colors.white38 : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? Colors.white24 : Colors.grey[300],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

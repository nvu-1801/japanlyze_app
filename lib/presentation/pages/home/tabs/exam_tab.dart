import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/exam.dart';
import '../../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../../injection_container.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../exam/exam_detail_page.dart';
import '../../exam/exam_history_page.dart';

/// Map of JLPT level to color for consistent visual identity
const Map<String, Color> _levelColors = {
  'N5': Color(0xFF22c55e), // green
  'N4': Color(0xFFa855f7), // purple
  'N3': Color(0xFF3b82f6), // blue
  'N2': Color(0xFFf97316), // orange
  'N1': Color(0xFFef4444), // red
};

Color _getLevelColor(String level) {
  for (final entry in _levelColors.entries) {
    if (level.contains(entry.key)) return entry.value;
  }
  return AppColors.primary;
}

class ExamTab extends StatefulWidget {
  const ExamTab({super.key});

  @override
  State<ExamTab> createState() => _ExamTabState();
}

class _ExamTabState extends State<ExamTab> {
  final ExamRemoteDataSource _dataSource = sl<ExamRemoteDataSource>();
  List<Exam> _exams = [];
  bool _isLoading = true;
  String? _error;

  String _selectedLevel = 'Tất cả';
  final List<String> _levels = ['Tất cả', 'N1', 'N2', 'N3', 'N4', 'N5'];

  List<Exam> get _filteredExams {
    if (_selectedLevel == 'Tất cả') return _exams;
    return _exams.where((e) => e.level.contains(_selectedLevel)).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchExams();
  }

  Future<void> _fetchExams() async {
    try {
      final exams = await _dataSource.getExams();
      if (mounted) {
        setState(() {
          _exams = exams;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching exams: $e');
      if (mounted) {
        setState(() {
          _error = 'Không thể tải đề thi. Vui lòng thử lại sau.';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _startQuickPractice(List<String> selectedLevels) async {
    if (_exams.isEmpty) return;

    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    try {
      // Filter exams by selectedLevels
      List<Exam> pool = _exams;
      if (selectedLevels.isNotEmpty) {
        final levelsSet = selectedLevels
            .map((l) => l.toUpperCase().trim())
            .toSet();
        pool = _exams.where((e) {
          final l = e.level.toUpperCase().trim();
          return levelsSet.contains(l);
        }).toList();
      }

      if (pool.isEmpty) {
        if (mounted) {
          Navigator.pop(context); // Remove loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Không tìm thấy đề thi cho các trình độ đã chọn'),
            ),
          );
        }
        return;
      }

      // Pick up to 5 random exams to pull questions from for better diversity
      final shuffledExams = List<Exam>.from(pool)..shuffle();
      final targetExams = shuffledExams.take(5).toList();

      List<Question> questionPool = [];

      for (var exam in targetExams) {
        try {
          final detail = await _dataSource.getExamDetail(exam.id);
          if (detail.questions != null) {
            questionPool.addAll(detail.questions!);
          }
        } catch (e) {
          debugPrint('Error fetching exam detail for quick practice: $e');
        }
      }

      if (questionPool.isEmpty) {
        if (mounted) {
          Navigator.pop(context); // Remove loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy câu hỏi.')),
          );
        }
        return;
      }

      // Shuffle and pick 10
      questionPool.shuffle();
      final randomQuestions = questionPool.take(10).toList();

      if (mounted) {
        Navigator.pop(context); // Remove loading
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamDetailPage(
              examId: 'quick-practice',
              title: 'Ôn luyện nhanh',
              initialExam: Exam(
                id: 'quick-practice',
                title: 'Ôn luyện nhanh',
                level: 'Mixed',
                duration: 0,
                isPremium: false,
                questionCount: randomQuestions.length,
                questions: randomQuestions,
              ),
              isQuickPractice: true,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Quick Practice error: $e');
      if (mounted) {
        Navigator.pop(context); // Remove loading
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã có lỗi xảy ra.')));
      }
    }
  }

  void _showLevelSelection() {
    Set<String> localSelected = {};
    final Map<String, Color> displayLevels = {..._levelColors};

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chọn trình độ ôn luyện',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setSheetState(() {
                        if (localSelected.length == displayLevels.length) {
                          localSelected.clear();
                        } else {
                          localSelected = displayLevels.keys.toSet();
                        }
                      });
                    },
                    child: Text(
                      localSelected.length == displayLevels.length
                          ? 'Bỏ chọn tất cả'
                          : 'Chọn tất cả',
                      style: GoogleFonts.lexend(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Hệ thống sẽ trộn các câu hỏi đúng với trình độ bạn chọn.',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: displayLevels.keys.map((level) {
                  final color = displayLevels[level]!;
                  final isSelected = localSelected.contains(level);
                  return GestureDetector(
                    onTap: () {
                      setSheetState(() {
                        if (isSelected) {
                          localSelected.remove(level);
                        } else {
                          localSelected.add(level);
                        }
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 48 - 24) / 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withValues(alpha: 0.2)
                            : color.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? color
                              : color.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            level,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: localSelected.isEmpty
                      ? null
                      : () {
                          Navigator.pop(context);
                          _startQuickPractice(localSelected.toList());
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Bắt đầu ôn luyện',
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = context.watch<AuthBloc>().state;
    final isPremiumUser =
        authState is AuthAuthenticated && authState.user.isPremium;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Đề thi',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                  fontSize: 22,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            ),
            actions: [
              PopupMenuButton<String>(
                initialValue: _selectedLevel,
                onSelected: (level) {
                  if (mounted) {
                    setState(() {
                      _selectedLevel = level;
                    });
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_list_rounded,
                        size: 20,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _selectedLevel,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.zero,
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => _levels.map((lvl) {
                  final color = lvl == 'Tất cả'
                      ? AppColors.primary
                      : _getLevelColor(lvl);
                  return PopupMenuItem<String>(
                    value: lvl,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          lvl,
                          style: GoogleFonts.lexend(
                            fontWeight: _selectedLevel == lvl
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExamHistoryPage(),
                    ),
                  );
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.history_rounded,
                    size: 20,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          SliverToBoxAdapter(child: _buildQuickPracticeBanner(context, isDark)),
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (_error != null)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexend(
                          color: isDark ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _error = null;
                          });
                          _fetchExams();
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text('Thử lại', style: GoogleFonts.lexend()),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_filteredExams.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Hiện chưa có đề thi nào phù hợp.',
                  style: GoogleFonts.lexend(
                    color: isDark ? Colors.white54 : Colors.grey[500],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _ExamCard(
                    exam: _filteredExams[index],
                    isPremiumUser: isPremiumUser,
                  ),
                  childCount: _filteredExams.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickPracticeBanner(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _showLevelSelection,
          icon: const Icon(Icons.bolt_rounded),
          label: Text(
            'Ôn luyện nhanh',
            style: GoogleFonts.lexend(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final Exam exam;
  final bool isPremiumUser;

  const _ExamCard({required this.exam, required this.isPremiumUser});

  void _handleTap(BuildContext context) {
    if (exam.isPremium && !isPremiumUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bạn cần tài khoản Premium để làm đề thi này.',
            style: GoogleFonts.lexend(),
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExamDetailPage(examId: exam.id, title: exam.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleTap(context),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Level Badge with level-specific color
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getLevelColor(
                            exam.level,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _getLevelColor(
                              exam.level,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          exam.level,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getLevelColor(exam.level),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (exam.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'PREMIUM',
                                style: GoogleFonts.lexend(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    exam.title,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InfoItem(
                        icon: Icons.timer_outlined,
                        label: '${exam.duration} phút',
                      ),
                      const SizedBox(width: 24),
                      _InfoItem(
                        icon: Icons.help_outline_rounded,
                        label: '${exam.questionCount} câu hỏi',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _handleTap(context),
                      icon: const Icon(Icons.play_arrow_rounded, size: 20),
                      label: Text(
                        'Bắt đầu làm bài',
                        style: GoogleFonts.lexend(fontWeight: FontWeight.w600),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, size: 16, color: isDark ? Colors.white38 : Colors.grey[500]),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 13,
            color: isDark ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

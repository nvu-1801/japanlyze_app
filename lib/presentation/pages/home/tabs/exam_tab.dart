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
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ôn luyện nhanh đang phát triển!',
                style: GoogleFonts.lexend(),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.85),
                AppColors.primaryDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ôn luyện nhanh',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '10 câu ngẫu nhiên - Không tính giờ',
                      style: GoogleFonts.lexend(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),
            ],
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

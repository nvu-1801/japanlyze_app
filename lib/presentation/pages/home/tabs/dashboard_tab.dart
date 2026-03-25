import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/roadmap_models.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../../pages/lesson/conversation_lesson_page.dart';
import '../../../pages/lesson/srs_flashcard_page.dart';
import 'roadmap/roadmap_utils.dart';
import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../blocs/dashboard/dashboard_event.dart';
import '../../../blocs/dashboard/dashboard_state.dart';
import '../widgets/quick_search_sheet.dart';
import 'dashboard/widgets/modern_stats_row.dart';
import 'dashboard/widgets/next_milestone_card.dart';
import 'dashboard/widgets/recommended_exercises.dart';
import 'dashboard/widgets/skeletons/dashboard_exercise_card_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_header_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_milestone_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_stats_skeleton.dart';
import 'dashboard/widgets/quick_actions.dart';
import '../widgets/srs_dashboard_widget.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../data/datasources/remote/exam_remote_datasource.dart';
import '../../../../injection_container.dart';
import '../../../../domain/entities/exam.dart';
import '../reading_page.dart';
import '../../exam/exam_detail_page.dart';
import '../notifications_page.dart';
import 'package:japalyze/presentation/blocs/notification/notification_bloc.dart';
import 'package:japalyze/presentation/blocs/notification/notification_state.dart';
import 'dart:math' as math;

/// Dashboard tab with modern design using Bloc pattern
class DashboardTab extends StatefulWidget {
  final VoidCallback? onNavigateToRoadmap;
  final VoidCallback? onNavigateToReading;
  final VoidCallback? onNavigateToExams;
  final Function(int)? onNavigateToTab;

  const DashboardTab({
    super.key,
    this.onNavigateToRoadmap,
    this.onNavigateToReading,
    this.onNavigateToExams,
    this.onNavigateToTab,
  });

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with AutomaticKeepAliveClientMixin {
  int _srsRefreshTrigger = 0;
  final _examDs = sl<ExamRemoteDataSource>();

  final Map<String, Color> _levelColors = {
    'N5': const Color(0xFF22C55E),
    'N4': const Color(0xFFA855F7),
    'N3': const Color(0xFF3B82F6),
    'N2': const Color(0xFFF97316),
    'N1': const Color(0xFFEF4444),
  };

  void _refreshSRS() {
    setState(() {
      _srsRefreshTrigger++;
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    // Load dashboard data when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardBloc>().add(const DashboardLoadRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          // Loading state - show skeleton loaders
          if (state is DashboardLoading) {
            return _buildLoadingState();
          }

          // Error state - show error message
          if (state is DashboardError) {
            return _buildErrorState(state.message);
          }

          // Empty state - new user
          if (state is DashboardEmpty) {
            return _buildEmptyState();
          }

          // Loaded state - show dashboard content
          if (state is DashboardLoaded) {
            return _buildLoadedState(state, isDark);
          }

          // Initial state - show loading
          return _buildLoadingState();
        },
      ),
    );
  }

  /// Build loading state with skeleton loaders
  Widget _buildLoadingState() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: DashboardHeaderSkeleton()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          sliver: const SliverToBoxAdapter(child: DashboardStatsSkeleton()),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: const SliverToBoxAdapter(child: DashboardMilestoneSkeleton()),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bài tập đề xuất',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: index < 4 ? 12 : 0),
                      child: const DashboardExerciseCardSkeleton(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  /// Build error state
  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Có lỗi xảy ra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DashboardBloc>().add(
                  const DashboardRefreshRequested(),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build empty state for new users
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_rounded,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Chào mừng đến với Japanlyze!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bắt đầu hành trình học tiếng Nhật của bạn ngay hôm nay',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to first lesson or roadmap
                Navigator.pushNamed(context, '/roadmap');
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Bắt đầu bài học đầu tiên'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build loaded state with actual data
  Widget _buildLoadedState(DashboardLoaded state, bool isDark) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header & Profile Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/settings'),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: CachedNetworkImageProvider(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuBvfCNi-OtMjt0XTS_NqGqEepWrcaCWyGvU4dJ6yIP0s_y4ZDK0wQ-pfw3BevDO-4nIXerfUwcFa-hXCBA7CV2hO4Y2amw5YNqVRiNU67CE0D-1vP4sGBkv_sAoGHQmcuAjqXAJYMZ6i2FCNFOnWOUrBpgxtxWxY7yhd3QzfMpeCD2pqhtiAtIhtwuASKkMosLZMoFwaaxuMoVFEgs6RWU8LmK6l_g2B9ueOIRaI4F5Cexd4cljTRv7whyKLTsI7JS3jUX1ODb4phvf',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ohayou, ${state.user.name.split(' ').first}!',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Level ${state.currentJlptLevel} Roadmap',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: state.user.isPremium
                                        ? Colors.amber.withValues(alpha: 0.1)
                                        : AppColors.primary.withValues(
                                            alpha: 0.1,
                                          ),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: state.user.isPremium
                                          ? Colors.amber.withValues(alpha: 0.3)
                                          : AppColors.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                    ),
                                  ),
                                  child: Text(
                                    state.user.isPremium
                                        ? 'PREMIUM VIP'
                                        : 'BASIC',
                                    style: TextStyle(
                                      color: state.user.isPremium
                                          ? Colors.amber[800]
                                          : AppColors.primary,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _SparkleTranslateButton(
                      onTap: () => showQuickSearch(context),
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<NotificationBloc, NotificationState>(
                      builder: (context, notificationState) {
                        int unreadCount = 0;
                        if (notificationState is NotificationLoaded) {
                          unreadCount = notificationState.unreadCount;
                        }

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsPage(),
                            ),
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.05),
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_outlined,
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey[400],
                                  size: 20,
                                ),
                                if (unreadCount > 0)
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Stats Row (Compact)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          sliver: SliverToBoxAdapter(
            child: ModernStatsRow(
              streak: state.currentStreak,
              roadmap: state.currentJlptLevel,
              isPremium: state.user.isPremium,
            ),
          ),
        ),

        // Streak indicator (if streak > 0)
        if (state.currentStreak > 0)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${state.currentStreak} ngày liên tiếp!',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Quick Actions Section
        SliverPadding(
          padding: const EdgeInsets.only(top: 24),
          sliver: SliverToBoxAdapter(
            child: QuickActions(
              onQuickVocab: _startQuickVocab,
              onQuickReading: _showReadingLevels,
              onQuickExam: _showExamLevels,
            ),
          ),
        ),

        // Next Milestone Section (Prominent CTA)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          sliver: SliverToBoxAdapter(
            child: NextMilestoneCard(
              milestone: state.nextMilestone,
              progress: state.nextMilestoneProgress,
              onStartLesson: () {
                if (state.nextMilestone != null) {
                  _navigateToLesson(state.nextMilestone!);
                }
              },
            ),
          ),
        ),

        // SRS Dashboard (Moved below Milestone)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
          sliver: SliverToBoxAdapter(
            child: SRSDashboardWidget(key: ValueKey('srs_$_srsRefreshTrigger')),
          ),
        ),

        // Priority Lessons (Hiragana & Katakana)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: RecommendedExercises(
              title: 'Bài học ưu tiên',
              exercises: state.priorityExercises,
              onLessonTap: (lesson) {
                _navigateToLesson(lesson);
              },
            ),
          ),
        ),

        // Recommended Reading Articles
        if (state.recommendedReading.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đề xuất đọc',
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => widget.onNavigateToReading?.call(),
                        child: Row(
                          children: [
                            Text(
                              'Xem tất cả',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.recommendedReading.length,
                      itemBuilder: (context, index) {
                        final article = state.recommendedReading[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReadingDetailPage(article: article),
                              ),
                            );
                          },
                          child: Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark
                                    ? Colors.grey[800]!
                                    : Colors.grey[200]!,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.book_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        article.title,
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        article.level,
                                        style: GoogleFonts.lexend(
                                          fontSize: 11,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Topic-based Exercises
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: RecommendedExercises(
              title: 'Bài tập theo chủ đề',
              exercises: state.topicExercises,
              onSeeAll: () => widget.onNavigateToTab?.call(3),
              onLessonTap: (lesson) {
                final lessonData = conversationData
                    .where((c) => c.id == lesson.id)
                    .firstOrNull;
                if (lessonData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConversationLessonPage(lesson: lessonData),
                    ),
                  );
                }
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  void _startQuickVocab() {
    final allVocab = conversationData.expand((l) => l.vocabItems).toList();
    if (allVocab.isEmpty) return;

    allVocab.shuffle();
    final practiceVocab = allVocab.take(30).toList();

    final practiceLesson = ConversationLesson(
      id: 'quick_practice',
      title: 'Luyện tập nhanh từ vựng',
      description: 'Luyện tập ngẫu nhiên từ vựng từ tất cả chủ đề.',
      vocabItems: practiceVocab,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SRSFlashcardPage(
          lesson: practiceLesson,
          title: 'Luyện tập nhanh từ vựng',
        ),
      ),
    ).then((_) => _refreshSRS());
  }

  void _showReadingLevels() {
    Set<String> localSelected = {};
    final readingLevels = {
      'Beginner': const Color(0xFF10B981),
      ..._levelColors,
    };

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
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn trình độ đọc',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: readingLevels.entries.map((entry) {
                  final isSelected = localSelected.contains(entry.key);
                  return GestureDetector(
                    onTap: () => setSheetState(() {
                      if (isSelected)
                        localSelected.remove(entry.key);
                      else
                        localSelected.add(entry.key);
                    }),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 48 - 24) / 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? entry.value.withOpacity(0.2)
                            : entry.value.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? entry.value
                              : entry.value.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          entry.key,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: entry.value,
                          ),
                        ),
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
                          _startReadingChallenge(localSelected.toList());
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Bắt đầu thử thách'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startReadingChallenge(List<String> levels) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
    try {
      final randoms = await _examDs.getRandomReadingArticles();
      final levelsSet = levels.map((l) => l.toUpperCase()).toSet();
      final filtered = randoms
          .where((a) => levelsSet.contains(a.level.toUpperCase()))
          .toList();

      if (!mounted) return;
      Navigator.pop(context); // hide loading

      if (filtered.isNotEmpty) {
        final article = filtered[math.Random().nextInt(filtered.length)];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReadingDetailPage(
              article: article,
              isChallenge: true,
              selectedLevels: levels,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không tìm thấy bài đọc phù hợp.')),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
    }
  }

  void _showExamLevels() {
    Set<String> localSelected = {};
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
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn trình độ thi thử',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _levelColors.entries.map((entry) {
                  final isSelected = localSelected.contains(entry.key);
                  return GestureDetector(
                    onTap: () => setSheetState(() {
                      if (isSelected)
                        localSelected.remove(entry.key);
                      else
                        localSelected.add(entry.key);
                    }),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 48 - 24) / 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? entry.value.withOpacity(0.2)
                            : entry.value.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? entry.value
                              : entry.value.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          entry.key,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: entry.value,
                          ),
                        ),
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
                          _startExamPractice(localSelected.toList());
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Bắt đầu ôn luyện'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startExamPractice(List<String> levels) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
    try {
      final allExams = await _examDs.getExams();
      final levelsSet = levels.map((l) => l.toUpperCase()).toSet();
      final pool = allExams
          .where((e) => levelsSet.contains(e.level.toUpperCase()))
          .toList();

      if (pool.isEmpty) {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy đề thi.')),
          );
        }
        return;
      }

      pool.shuffle();
      final targetExams = pool.take(3).toList();
      List<Question> questionPool = [];
      for (var ex in targetExams) {
        final d = await _examDs.getExamDetail(ex.id);
        if (d.questions != null) questionPool.addAll(d.questions!);
      }

      if (!mounted) return;
      Navigator.pop(context);

      if (questionPool.isNotEmpty) {
        questionPool.shuffle();
        final finalQuestions = questionPool.take(10).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExamDetailPage(
              examId: 'quick-practice',
              title: 'Ôn luyện nhanh',
              initialExam: Exam(
                id: 'quick-practice',
                title: 'Ôn luyện nhanh',
                level: 'Mixed',
                duration: 0,
                isPremium: false,
                questionCount: finalQuestions.length,
                questions: finalQuestions,
              ),
              isQuickPractice: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Không có câu hỏi.')));
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
    }
  }

  /// Navigate to lesson based on quest type
  void _navigateToLesson(dynamic quest) {
    if (quest is RoadmapQuest) {
      final lessonId = RoadmapUtils.mapLinkToId(quest.link);
      final lessonData = conversationData
          .where((c) => c.id == lessonId)
          .firstOrNull;

      if (lessonData != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => quest.type == 'flashcard'
                ? SRSFlashcardPage(
                    lesson: lessonData,
                    questId: quest.id,
                    onProgressUpdated: () {
                      _refreshSRS();
                      // Reload dashboard after progress update
                      context.read<DashboardBloc>().add(
                        const DashboardLoadRequested(),
                      );
                    },
                  )
                : ConversationLessonPage(
                    lesson: lessonData,
                    questId: quest.id,
                    onProgressUpdated: () {
                      // Reload dashboard after progress update
                      context.read<DashboardBloc>().add(
                        const DashboardLoadRequested(),
                      );
                    },
                  ),
          ),
        ).then((_) => _refreshSRS());
      } else {
        // Fallback to roadmap if lesson data not ready
        widget.onNavigateToRoadmap?.call();
      }
    } else {
      // For other types, go to roadmap
      Navigator.pushNamed(context, '/roadmap');
    }
  }
}

class _SparkleTranslateButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SparkleTranslateButton({required this.onTap});

  @override
  State<_SparkleTranslateButton> createState() =>
      _SparkleTranslateButtonState();
}

class _SparkleTranslateButtonState extends State<_SparkleTranslateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Point> _stars = List.generate(
    5,
    (i) => Point(
      x: 5.0 + (i * 7.0) % 30.0,
      y: 5.0 + (i * 9.0) % 30.0,
      delay: i * 0.2,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.translate_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.grey[700],
              size: 20,
            ),
          ),
          ..._stars.map((star) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final progress = (_controller.value + star.delay) % 1.0;
                final opacity = (progress < 0.5)
                    ? progress * 2
                    : (1.0 - progress) * 2;
                final scale = 0.5 + opacity * 0.5;

                return Positioned(
                  left: star.x,
                  top: star.y,
                  child: Opacity(
                    opacity: opacity.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: scale,
                      child: const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFD700), // Gold/Amber
                        size: 8,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class Point {
  final double x;
  final double y;
  final double delay;
  Point({required this.x, required this.y, required this.delay});
}

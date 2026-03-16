import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../blocs/dashboard/dashboard_event.dart';
import '../../../blocs/dashboard/dashboard_state.dart';
import '../../lesson/flashcard_page.dart';
import '../../lesson/conversation_lesson_page.dart';
import '../widgets/quick_search_sheet.dart';
import 'dashboard/widgets/flashcard_decks.dart';
import 'dashboard/widgets/modern_stats_row.dart';
import 'dashboard/widgets/next_milestone_card.dart';
import 'dashboard/widgets/recommended_exercises.dart';
import 'dashboard/widgets/skeletons/dashboard_exercise_card_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_flashcard_deck_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_header_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_milestone_skeleton.dart';
import 'dashboard/widgets/skeletons/dashboard_stats_skeleton.dart';

/// Dashboard tab with modern design using Bloc pattern
class DashboardTab extends StatefulWidget {
  final VoidCallback? onSeeAllFlashcards;
  const DashboardTab({super.key, this.onSeeAllFlashcards});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with AutomaticKeepAliveClientMixin {
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
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bộ thẻ mẫu',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: index < 3 ? 16 : 0),
                      child: const DashboardFlashcardDeckSkeleton(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<DashboardBloc>()
                    .add(const DashboardRefreshRequested());
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
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/settings'),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ohayou, ${state.user.name.split(' ').first}!',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${state.user.currentLevel ?? "N5"} Journey',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                'LEVEL ${state.user.level}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    _SparkleTranslateButton(
                      onTap: () => showQuickSearch(context),
                    ),
                    const SizedBox(width: 8),
                    Container(
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
                            color: isDark ? Colors.white54 : Colors.grey[400],
                            size: 20,
                          ),
                          if (state.currentStreak > 0)
                            Positioned(
                              top: 8,
                              right: 8,
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
              xp: state.displayedXP,
              level: state.user.level,
              phase: state.user.currentPhase,
            ),
          ),
        ),

        // Streak indicator (if streak > 0)
        if (state.currentStreak > 0)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

        // Recommended Exercises (with lazy loading)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: Visibility(
              visible: state.recommendedExercises.isNotEmpty,
              child: RecommendedExercises(
                exercises: state.recommendedExercises,
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
        ),

        // Sample Flashcard Decks (with lazy loading)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          sliver: SliverToBoxAdapter(
            child: Visibility(
              visible: state.flashcardDecks.isNotEmpty,
              child: FlashcardDecks(
                decks: state.flashcardDecks,
                onSeeAll: widget.onSeeAllFlashcards,
                onDeckTap: (lesson) {
                  final lessonData = conversationData
                      .where((c) => c.id == lesson.id)
                      .firstOrNull;
                  if (lessonData != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FlashcardPage(lesson: lessonData),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  /// Navigate to lesson based on quest type
  void _navigateToLesson(dynamic quest) {
    // This would navigate to the appropriate lesson page
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang mở: ${quest.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../lesson/flashcard_page.dart';
import '../../lesson/conversation_lesson_page.dart';
import '../widgets/quick_search_sheet.dart';

/// Dashboard tab with modern design
class DashboardTab extends StatefulWidget {
  final VoidCallback? onSeeAllFlashcards;
  const DashboardTab({super.key, this.onSeeAllFlashcards});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final user = state is AuthAuthenticated
              ? state.user
              : User(
                  uuid: '',
                  name: 'Mock User',
                  email: 'mock@example.com',
                  role: 'user',
                  isPremium: true,
                  level: 5,
                  currentLevel: 'N5',
                  currentPhase: 1,
                  onboardingCompleted: true,
                  createdAt: DateTime.now(),
                );

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
                            onTap: () =>
                                Navigator.pushNamed(context, '/settings'),
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
                                'Ohayou, ${user.name.split(' ').first}!',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${user.currentLevel ?? "N5"} Journey',
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
                                      'LEVEL ${user.level}',
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
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.05),
                              ),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: isDark ? Colors.white54 : Colors.grey[400],
                              size: 20,
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
                sliver: SliverToBoxAdapter(child: _ModernStatsRow(user: user)),
              ),

              // Next Milestone Section (Prominent CTA)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                sliver: SliverToBoxAdapter(child: const _NextMilestoneCard()),
              ),

              // Recommended Exercises
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                sliver: SliverToBoxAdapter(
                  child: _ModernRecommendedExercises(
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

              // Sample Flashcard Decks
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                sliver: SliverToBoxAdapter(
                  child: _ModernFlashcardDecks(
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

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }
}

class _NextMilestoneCard extends StatelessWidget {
  const _NextMilestoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CỘT MỐC TIẾP THEO',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Động từ Tự động & Tha động',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Dự kiến: 15 phút • 20 XP',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Bắt đầu bài học'),
                    const SizedBox(width: 8),
                    const Icon(Icons.play_arrow_rounded, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(Icons.school_rounded, size: 72, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernStatsRow extends StatelessWidget {
  final User user;

  const _ModernStatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ModernStatItem(
            icon: Icons.bolt_rounded,
            color: Colors.amber,
            label: 'XP',
            value: '${user.exp}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: Icons.workspace_premium_rounded,
            color: Colors.blue,
            label: 'Level',
            value: '${user.level}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatItem(
            icon: Icons.flag_rounded,
            color: Colors.green,
            label: 'Phase',
            value: '${user.currentPhase}',
          ),
        ),
      ],
    );
  }
}

class _ModernStatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _ModernStatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
        ],
      ),
    );
  }
}

class _ModernRecommendedExercises extends StatelessWidget {
  final Function(LessonItem) onLessonTap;

  const _ModernRecommendedExercises({required this.onLessonTap});

  @override
  Widget build(BuildContext context) {
    // Flatten categories to get a list of hot/recommended lessons
    final recommendedLessons = exerciseCategories
        .expand((cat) => cat.lessons)
        .take(5)
        .toList();

    return Column(
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
            itemCount: recommendedLessons.length,
            itemBuilder: (context, index) {
              final lessonItem = recommendedLessons[index];
              return GestureDetector(
                onTap: () => onLessonTap(lessonItem),
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]!
                          : Colors.grey[100]!,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: lessonItem.color.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          lessonItem.icon,
                          color: lessonItem.color,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        lessonItem.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ModernFlashcardDecks extends StatelessWidget {
  final Function(LessonItem) onDeckTap;
  final VoidCallback? onSeeAll;

  const _ModernFlashcardDecks({required this.onDeckTap, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    // Get vocabulary categories for sample decks
    final sampleDecks = exerciseCategories[1].lessons.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bộ thẻ mẫu',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'Xem tất cả',
                style: GoogleFonts.lexend(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: sampleDecks.length,
            itemBuilder: (context, index) {
              final deck = sampleDecks[index];
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return GestureDetector(
                onTap: () => onDeckTap(deck),
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: index == 0
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : (isDark ? Colors.grey[800]! : Colors.grey[100]!),
                      width: index == 0 ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      if (index == 0)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'HOT',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: deck.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                deck.icon,
                                color: deck.color,
                                size: 28,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              deck.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Chương trình N5',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
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

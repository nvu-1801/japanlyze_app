import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/user.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../../infrastructure/repositories/flashcard_repository.dart';
import '../../../../infrastructure/repositories/user_progress_service.dart';
import '../../../../infrastructure/datasources/local/conversation_data.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../domain/entities/flashcard_models.dart';

/// Dashboard tab with modern design
class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Progress State
  int _flashcardsStudied = 0;
  int _flashcardsTotal = 0;
  int _vocabCompleted = 0;
  int _vocabTotal = 0;
  int _conversationCompleted = 0;
  int _conversationTotal = 0;
  double _overallProgress = 0.0;
  bool _isLoadingProgress = true;
  List<FlashcardSet> _flashcardSets = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    
    _loadProgressData();
  }

  Future<void> _loadProgressData() async {
    // 1. Load Flashcards Progress
    final sets = await FlashcardRepository().getFlashcardSets();
    int fcStudied = 0;
    int fcTotal = 0;
    for (var set in sets) {
      fcStudied += set.studiedCount;
      fcTotal += set.cards.length;
    }

    // 2. Load Exercises Progress
    final completedLessons = await UserProgressService().getCompletedLessons();
    
    // Group 1: Intro (0) & Vocab (1) -> "Vocabulary"
    // Group 2: Conversation (2) -> "Conversation"
    
    int vCompleted = 0;
    int vTotal = 0;
    int cCompleted = 0;
    int cTotal = 0;

    // Helper to count
    void countCategory(int index, {required bool isConversation}) {
      if (index < exerciseCategories.length) {
        final cat = exerciseCategories[index];
        for (var lesson in cat.lessons) {
          if (isConversation) {
            cTotal++;
            if (completedLessons.contains(lesson.id)) cCompleted++;
          } else {
            vTotal++;
            if (completedLessons.contains(lesson.id)) vCompleted++;
          }
        }
      }
    }

    // Intro & Vocab
    countCategory(0, isConversation: false);
    countCategory(1, isConversation: false);
    
    // Conversation
    countCategory(2, isConversation: true);

    // Calculate overall progress
    final totalItems = fcTotal + vTotal + cTotal;
    final totalCompleted = fcStudied + vCompleted + cCompleted;
    final progress = totalItems > 0 ? totalCompleted / totalItems : 0.0;

    if (mounted) {
      setState(() {
        _flashcardsStudied = fcStudied;
        _flashcardsTotal = fcTotal;
        _vocabCompleted = vCompleted;
        _vocabTotal = vTotal;
        _conversationCompleted = cCompleted;
        _conversationTotal = cTotal;
        _overallProgress = progress;
        _flashcardSets = sets;
        _isLoadingProgress = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ðŸŒ…';
    if (hour < 17) return 'Good afternoon â˜€ï¸';
    return 'Good evening ðŸŒ™';
  }

  Widget _buildAnimatedSection({required double delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: (600 + delay * 400).toInt()),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated
              ? state.user
              : User(
                  id: 1,
                  name: 'Mock User',
                  email: 'mock@example.com',
                  role: 'user',
                  isPremium: true,
                  createdAt: DateTime.now(),
                  streakCount: 7,
                  exp: 1250,
                  level: 5,
                  uuid: '',
                );

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Modern App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  _AnimatedIconButton(
                    icon: Icons.notifications_outlined,
                    onPressed: () {},
                    badge: 3,
                  ),
                  _AnimatedIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              // Content
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _ModernStreakCard(user: user),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      delay: 0.2,
                      child: _ModernStatsRow(user: user),
                    ),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      delay: 0.3,
                      child: _ModernProgressCard(
                        flashcardsStudied: _flashcardsStudied,
                        flashcardsTotal: _flashcardsTotal,
                        vocabCompleted: _vocabCompleted,
                        vocabTotal: _vocabTotal,
                        conversationCompleted: _conversationCompleted,
                        conversationTotal: _conversationTotal,
                        overallProgress: _overallProgress,
                        isLoading: _isLoadingProgress,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      delay: 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quick Actions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('See all'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const _ModernQuickActions(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      delay: 0.5,
                      child: _FlashcardProgressSection(sets: _flashcardSets),
                    ),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      delay: 0.6,
                      child: const _RecentActivitySection(),
                    ),
                    const SizedBox(height: 100), // Bottom padding for FAB
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final int? badge;

  const _AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    this.badge,
  });

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, size: 22),
            ),
            if (widget.badge != null)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${widget.badge}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModernStreakCard extends StatelessWidget {
  final User user;

  const _ModernStreakCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ðŸ”¥ ${user.streakCount} day streak!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keep learning to\nmaintain your streak!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF667eea),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Start Today\'s Lesson'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _AnimatedFireIcon(),
        ],
      ),
    );
  }
}

class _AnimatedFireIcon extends StatefulWidget {
  @override
  State<_AnimatedFireIcon> createState() => _AnimatedFireIconState();
}

class _AnimatedFireIconState extends State<_AnimatedFireIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_controller.value * 0.1),
          child: Transform.rotate(
            angle: math.sin(_controller.value * math.pi * 2) * 0.05,
            child: const Text('ðŸ”¥', style: TextStyle(fontSize: 72)),
          ),
        );
      },
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
          child: _ModernStatCard(
            icon: Icons.bolt_rounded,
            iconColor: AppColors.warning,
            title: 'XP',
            value: '${user.exp}',
            subtitle: 'points',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ModernStatCard(
            icon: Icons.school_rounded,
            iconColor: AppColors.success,
            title: 'Level',
            value: '${user.level}',
            subtitle: 'current',
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: _ModernStatCard(
            icon: Icons.style_rounded,
            iconColor: AppColors.info,
            title: 'Cards',
            value: '124',
            subtitle: 'learned',
          ),
        ),
      ],
    );
  }
}

class _ModernStatCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _ModernStatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  State<_ModernStatCard> createState() => _ModernStatCardState();
}

class _ModernStatCardState extends State<_ModernStatCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.iconColor, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModernProgressCard extends StatelessWidget {
  final int flashcardsStudied;
  final int flashcardsTotal;
  final int vocabCompleted;
  final int vocabTotal;
  final int conversationCompleted;
  final int conversationTotal;
  final double overallProgress;
  final bool isLoading;

  const _ModernProgressCard({
    this.flashcardsStudied = 0,
    this.flashcardsTotal = 0,
    this.vocabCompleted = 0,
    this.vocabTotal = 0,
    this.conversationCompleted = 0,
    this.conversationTotal = 0,
    this.overallProgress = 0.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Learning Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(overallProgress * 100).toInt()}% completed',
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _AnimatedProgressBar(progress: overallProgress),
          const SizedBox(height: 20),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ProgressItem(
                icon: Icons.style_rounded,
                label: 'Flashcards',
                value: '$flashcardsStudied/$flashcardsTotal',
                isCompleted: flashcardsTotal > 0 && flashcardsStudied >= flashcardsTotal,
              ),
              _ProgressItem(
                icon: Icons.school_rounded,
                label: 'Vocabulary',
                value: '$vocabCompleted/$vocabTotal',
                isCompleted: vocabTotal > 0 && vocabCompleted >= vocabTotal,
              ),
              _ProgressItem(
                icon: Icons.camera_indoor_rounded, // or chat_rounded
                label: 'Dialogue',
                value: '$conversationCompleted/$conversationTotal',
                isCompleted: conversationTotal > 0 && conversationCompleted >= conversationTotal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedProgressBar extends StatefulWidget {
  final double progress;

  const _AnimatedProgressBar({required this.progress});

  @override
  State<_AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<_AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _animation.value,
            minHeight: 12,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      },
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isCompleted;

  const _ProgressItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.success.withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check_rounded : icon,
            color: isCompleted ? AppColors.success : Colors.grey,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _ModernQuickActions extends StatelessWidget {
  const _ModernQuickActions();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _QuickActionItem(
            icon: Icons.translate_rounded,
            label: 'Translate',
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
          ),
          _QuickActionItem(
            icon: Icons.school_rounded,
            label: 'Learn Kana',
            gradient: LinearGradient(
              colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
            ),
          ),
          _QuickActionItem(
            icon: Icons.chat_bubble_rounded,
            label: 'AI Chat',
            gradient: LinearGradient(
              colors: [Color(0xFFee0979), Color(0xFFff6a00)],
            ),
          ),
          _QuickActionItem(
            icon: Icons.people_rounded,
            label: 'Community',
            gradient: LinearGradient(
              colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            ),
          ),
          _QuickActionItem(
            icon: Icons.book_rounded,
            label: 'Dictionary',
            gradient: LinearGradient(
              colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Gradient gradient;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.gradient,
  });

  @override
  State<_QuickActionItem> createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<_QuickActionItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        // TODO: Navigate
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 90,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.style_rounded,
          iconColor: AppColors.primary,
          title: 'Studied JLPT N5 Deck',
          subtitle: '30 cards reviewed',
          time: '2 hours ago',
        ),
        _ActivityItem(
          icon: Icons.quiz_rounded,
          iconColor: AppColors.success,
          title: 'Completed Quiz',
          subtitle: 'Score: 85%',
          time: '5 hours ago',
        ),
        _ActivityItem(
          icon: Icons.emoji_events_rounded,
          iconColor: AppColors.warning,
          title: 'Achievement Unlocked',
          subtitle: '7-day streak!',
          time: 'Yesterday',
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}

class _FlashcardProgressSection extends StatelessWidget {
  final List<FlashcardSet> sets;

  const _FlashcardProgressSection({required this.sets});

  @override
  Widget build(BuildContext context) {
    if (sets.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Flashcards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to Flashcards Tab or specific "All Decks" view if needed
                // For now, maybe just switch tab or do nothing
              },
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...sets.take(3).map((set) => _FlashcardTrackingCard(set: set)).toList(),
      ],
    );
  }
}

class _FlashcardTrackingCard extends StatefulWidget {
  final FlashcardSet set;

  const _FlashcardTrackingCard({required this.set});

  @override
  State<_FlashcardTrackingCard> createState() => _FlashcardTrackingCardState();
}

class _FlashcardTrackingCardState extends State<_FlashcardTrackingCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final progress = widget.set.cards.isNotEmpty
        ? widget.set.studiedCount / widget.set.cards.length
        : 0.0;
    final percentage = (progress * 100).toInt();
    final isCompleted = progress >= 1.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        // TODO: Navigate to Study Page for this set
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green.shade50.withOpacity(0.5) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCompleted ? Colors.green.shade200 : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.style_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.set.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            isCompleted ? 'Completed' : 'In Progress',
                            style: TextStyle(
                              fontSize: 13,
                              color: isCompleted ? Colors.green : Colors.grey[500],
                              fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                          if (progress > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '$percentage%',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (!isCompleted && progress > 0) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[100],
                            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                 if (isCompleted)
                  Icon(
                    Icons.check_circle,
                    color: Colors.green[500],
                    size: 20,
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[300],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

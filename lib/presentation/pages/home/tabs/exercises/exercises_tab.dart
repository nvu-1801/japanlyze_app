import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../data/datasources/local/conversation_data.dart';
import '../../../../../../domain/entities/conversation_models.dart';
import 'widgets/exercise_card.dart';

import '../../../../../../presentation/pages/lesson/conversation_lesson_page.dart';
import '../../../../../../presentation/pages/lesson/flashcard_page.dart';
import '../../../../../../data/services/user_progress_service.dart';

/// Max items shown per category before collapsing
const _maxVisibleItems = 4;

/// Exercises tab with modern design and lesson locking logic
class ExercisesTab extends StatefulWidget {
  const ExercisesTab({super.key});

  @override
  State<ExercisesTab> createState() => _ExercisesTabState();
}

class _ExercisesTabState extends State<ExercisesTab> {
  List<String> _completedLessons = [];
  final bool _isPremiumUser = false;

  /// Which categories are expanded (show all items)
  final Set<int> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await UserProgressService().getCompletedLessons();
    if (mounted) setState(() => _completedLessons = completed);
  }

  ({bool isLocked, List<LessonItem> missingLessons}) _checkLockStatus(
    String lessonId,
  ) {
    if (_isPremiumUser) {
      return (isLocked: false, missingLessons: <LessonItem>[]);
    }
    final convLesson = conversationData
        .where((c) => c.id == lessonId)
        .firstOrNull;
    if (convLesson == null || convLesson.prerequisites.isEmpty) {
      return (isLocked: false, missingLessons: <LessonItem>[]);
    }
    final missingIds = convLesson.prerequisites
        .where((id) => !_completedLessons.contains(id))
        .toList();

    if (missingIds.isNotEmpty) {
      final allLessons = exerciseCategories.expand((c) => c.lessons).toList();
      final missingLessons = missingIds.map((id) {
        final found = allLessons.where((l) => l.id == id).firstOrNull;
        if (found != null) return found;

        // Fallback for orphaned prerequisites
        return LessonItem(
          id: id,
          title: id,
          icon: Icons.book_rounded,
          color: Colors.grey,
          backgroundColor: Colors.grey[100],
        );
      }).toList();

      return (isLocked: true, missingLessons: missingLessons);
    }
    return (isLocked: false, missingLessons: <LessonItem>[]);
  }

  void _handleLockedTap(List<LessonItem> missingLessons) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(Icons.lock_rounded, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              'Bài học bị khóa',
              style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bạn cần hoàn thành các bài học sau để mở khóa:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ...missingLessons.map(
              (lesson) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToLesson(lesson.id);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Đóng',
              style: GoogleFonts.lexend(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToLesson(String lessonId) async {
    final lessonData = conversationData
        .where((c) => c.id == lessonId)
        .firstOrNull;
    if (lessonData == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lesson data not found for: $lessonId'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (lessonData.vocabItems.isNotEmpty && lessonData.lines.isNotEmpty) {
      // Show choice if both are available
      final choice = await showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chọn chế độ học',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.primary,
                ),
                title: const Text('Học Hội thoại'),
                subtitle: const Text('Luyện nghe và giao tiếp qua hội thoại'),
                onTap: () => Navigator.pop(context, 'conversation'),
              ),
              ListTile(
                leading: const Icon(Icons.bolt_rounded, color: Colors.orange),
                title: const Text('Học Flashcards'),
                subtitle: const Text('Ghi nhớ từ vựng nhanh chóng'),
                onTap: () => Navigator.pop(context, 'flashcard'),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );

      if (!context.mounted) {
        return;
      }

      if (choice == 'conversation') {
        _pushLessonPage(ConversationLessonPage(lesson: lessonData));
      } else if (choice == 'flashcard') {
        _pushLessonPage(FlashcardPage(lesson: lessonData));
      }
    } else if (lessonData.vocabItems.isNotEmpty) {
      _pushLessonPage(FlashcardPage(lesson: lessonData));
    } else {
      _pushLessonPage(ConversationLessonPage(lesson: lessonData));
    }
  }

  Future<void> _pushLessonPage(Widget page) async {
    if (!context.mounted) {
      return;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
    if (context.mounted && result == true) {
      _loadProgress();
    }
  }

  Widget _buildLessonCard(LessonItem lesson) {
    final isCompleted = _completedLessons.contains(lesson.id);
    final lockStatus = _checkLockStatus(lesson.id);
    return ExerciseCard(
      lesson: lesson,
      isLocked: lockStatus.isLocked,
      isCompleted: isCompleted,
      progress: isCompleted ? 1.0 : 0.0,
      onTap: () {
        if (lockStatus.isLocked) {
          _handleLockedTap(lockStatus.missingLessons);
        } else {
          _navigateToLesson(lesson.id);
        }
      },
    );
  }

  Widget _buildCompletedSection() {
    if (_completedLessons.isEmpty) {
      return const SizedBox.shrink();
    }

    final allLessons = exerciseCategories.expand((c) => c.lessons).toList();
    // Show up to 2 most recently completed lessons
    final recentIds = _completedLessons.reversed.take(2).toList();
    final recentLessons = recentIds
        .map((id) => allLessons.where((l) => l.id == id).firstOrNull)
        .whereType<LessonItem>()
        .toList();

    if (recentLessons.isEmpty) {
      return const SizedBox.shrink();
    }

    return _SectionWrapper(
      icon: Icons.check_circle_rounded,
      iconColor: Colors.green[600]!,
      title: 'Đã hoàn thành',
      subtitle: '${_completedLessons.length} bài học',
      children: recentLessons.map(_buildLessonCard).toList(),
    );
  }

  Widget _buildCategorySection(int index) {
    final category = exerciseCategories[index];
    final lessons = category.lessons;
    final isExpanded = _expandedCategories.contains(index);
    final showCollapse = lessons.length > _maxVisibleItems;
    final visibleLessons = (showCollapse && !isExpanded)
        ? lessons.take(_maxVisibleItems).toList()
        : lessons;

    return _SectionWrapper(
      icon: _categoryIcon(index),
      iconColor: _categoryColor(index),
      title: _cleanTitle(category.title),
      subtitle: '${lessons.length} bài học',
      children: [
        ...visibleLessons.map(_buildLessonCard),
        if (showCollapse)
          _ExpandButton(
            isExpanded: isExpanded,
            remaining: lessons.length - _maxVisibleItems,
            onTap: () => setState(() {
              if (isExpanded) {
                _expandedCategories.remove(index);
              } else {
                _expandedCategories.add(index);
              }
            }),
          ),
      ],
    );
  }

  String _cleanTitle(String title) {
    // Remove parenthetical suffixes for cleaner display, keep emoji
    return title.replaceAll(RegExp(r'\s*\(.*?\)'), '').trim();
  }

  IconData _categoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.text_fields_rounded;
      case 1:
        return Icons.book_rounded;
      case 2:
        return Icons.chat_bubble_rounded;
      default:
        return Icons.folder_rounded;
    }
  }

  Color _categoryColor(int index) {
    switch (index) {
      case 0:
        return Colors.pink[600]!;
      case 1:
        return Colors.green[600]!;
      case 2:
        return Colors.blue[600]!;
      default:
        return AppColors.primary;
    }
  }

  void _confirmReset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 12),
            Text(
              'Reset tiến độ',
              style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'Toàn bộ bài học đã hoàn thành sẽ bị xóa. Bạn có chắc không?',
          style: GoogleFonts.lexend(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: GoogleFonts.lexend(color: Colors.grey[600]),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await UserProgressService().clearProgress();
              await _loadProgress();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Đã reset toàn bộ tiến độ',
                      style: GoogleFonts.lexend(),
                    ),
                    backgroundColor: Colors.green[700],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: Text('Reset', style: GoogleFonts.lexend()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                tooltip: 'Reset tiến độ',
                icon: Icon(
                  Icons.restart_alt_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.black38,
                ),
                onPressed: _confirmReset,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Luyện tập',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.textPrimary,
                  fontSize: 22,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            ),
          ),

          // Intro banner
          const SliverToBoxAdapter(child: _IntroBanner()),

          // Completed lessons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: _buildCompletedSection(),
            ),
          ),

          // All categories
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCategorySection(index),
              ),
              childCount: exerciseCategories.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}

// ─────────────────────────  Sub-widgets  ─────────────────────────

class _SectionWrapper extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SectionWrapper({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.lexend(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _ExpandButton extends StatelessWidget {
  final bool isExpanded;
  final int remaining;
  final VoidCallback onTap;

  const _ExpandButton({
    required this.isExpanded,
    required this.remaining,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isExpanded ? 'Thu gọn' : 'Xem thêm $remaining bài học',
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroBanner extends StatelessWidget {
  const _IntroBanner();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Text('🎌', style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Luyện tập theo chủ đề từ cơ bản đến nâng cao — từ Hiragana đến hội thoại thực tế.',
              style: GoogleFonts.lexend(
                fontSize: 13,
                color: isDark
                    ? Colors.white70
                    : AppColors.textPrimary.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

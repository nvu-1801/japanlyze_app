import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../infrastructure/datasources/local/conversation_data.dart';
import '../../../../../../domain/entities/conversation_models.dart';
import 'widgets/exercise_card.dart';
import 'widgets/featured_section.dart';
import '../../../../../../presentation/pages/lesson/conversation_lesson_page.dart';
import '../../../../../../infrastructure/repositories/user_progress_service.dart';

/// Exercises tab with modern design and lesson locking logic
class ExercisesTab extends StatefulWidget {
  const ExercisesTab({super.key});

  @override
  State<ExercisesTab> createState() => _ExercisesTabState();
}

class _ExercisesTabState extends State<ExercisesTab> {
  // User progress loaded from persistent storage
  List<String> _completedLessons = [];
  
  // Mock premium status
  final bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await UserProgressService().getCompletedLessons();
    setState(() {
      _completedLessons = completed;
      // Add default unlocked lessons if empty (for new users)
      if (_completedLessons.isEmpty) {
         // Optionally pre-fill some if needed, but prerequisites handle logic
         // For now let's say hiragana/katakana are always open or base prereqs
      }
    });
  }

  /// Helper to get lesson title by ID for the lock message
  String _getLessonTitle(String id) {
    for (final category in exerciseCategories) {
      final found = category.lessons.where((l) => l.id == id).firstOrNull;
      if (found != null) return found.title;
    }
    return id; // Fallback if not found
  }

  /// Check if a lesson is locked based on prerequisites
  ({bool isLocked, List<String> missingTitles}) _checkLockStatus(String lessonId) {
    // If premium, everything is unlocked
    if (_isPremiumUser) {
      return (isLocked: false, missingTitles: <String>[]);
    }

    // Find the conversation data for this lesson
    // conversationData is imported from conversation_data.dart
    final convLesson = conversationData.where((c) => c.id == lessonId).firstOrNull;

    // If no conversation data found (e.g. it's a vocab lesson not in conversationData yet) 
    // or no prerequisites, it's open
    if (convLesson == null || convLesson.prerequisites.isEmpty) {
      return (isLocked: false, missingTitles: <String>[]);
    }

    // Check which prerequisites are missing from completedLessons
    final missingIds = convLesson.prerequisites.where((id) => !_completedLessons.contains(id)).toList();
    
    if (missingIds.isNotEmpty) {
      final missingTitles = missingIds.map((id) => _getLessonTitle(id)).toList();
      return (isLocked: true, missingTitles: missingTitles);
    }

    return (isLocked: false, missingTitles: <String>[]);
  }

  /// Show dialog when tapping a locked lesson
  void _handleLockedTap(List<String> missingTitles) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.lock, color: Colors.grey),
            SizedBox(width: 8),
            Text('Bài học bị khóa'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bạn cần hoàn thành các bài học sau để mở khóa:'),
            const SizedBox(height: 12),
            ...missingTitles.map((title) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 6, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title, 
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }


  /// Navigate to lesson detail page
  Future<void> _navigateToLesson(String lessonId) async {
    // Find the full lesson data
    final lessonData = conversationData.where((c) => c.id == lessonId).firstOrNull;

    if (lessonData != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationLessonPage(lesson: lessonData),
        ),
      );

      // If returned true, meaning lesson was completed
      if (result == true) {
        _loadProgress();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lesson data not found for: $lessonId'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: const Text(
              'Exercises',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          
          // Featured Section for "Useful Lessons"
          const SliverToBoxAdapter(
            child: FeaturedSection(),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = exerciseCategories[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              category.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...category.lessons.map((lesson) {
                        final isCompleted = _completedLessons.contains(lesson.id);
                        final lockStatus = _checkLockStatus(lesson.id);

                        return ExerciseCard(
                          lesson: lesson,
                          isLocked: lockStatus.isLocked,
                          isCompleted: isCompleted,
                          onTap: () {
                            if (lockStatus.isLocked) {
                              _handleLockedTap(lockStatus.missingTitles);
                            } else {
                              _navigateToLesson(lesson.id);
                            }
                          },
                        );
                      }),
                    ],
                  );
                },
                childCount: exerciseCategories.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}

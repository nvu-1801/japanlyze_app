import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../domain/entities/conversation_models.dart';

/// Recommended exercises with haptic feedback and lazy loading
class RecommendedExercises extends StatefulWidget {
  final List<LessonItem> exercises;
  final Function(LessonItem) onLessonTap;

  const RecommendedExercises({
    super.key,
    required this.exercises,
    required this.onLessonTap,
  });

  @override
  State<RecommendedExercises> createState() => _RecommendedExercisesState();
}

class _RecommendedExercisesState extends State<RecommendedExercises>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
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
            itemCount: widget.exercises.length,
            itemBuilder: (context, index) {
              final lessonItem = widget.exercises[index];
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  widget.onLessonTap(lessonItem);
                },
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
                          color: lessonItem.color != null
                              ? (lessonItem.color as Color).withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          lessonItem.icon is IconData
                              ? lessonItem.icon as IconData
                              : Icons.book_outlined,
                          color: lessonItem.color is Color
                              ? lessonItem.color as Color
                              : Colors.grey,
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

import 'package:flutter/material.dart';
import '../../../../domain/entities/conversation_models.dart';
import '../../../../core/constants/app_colors.dart';

import '../../../infrastructure/repositories/user_progress_service.dart';

class ConversationLessonPage extends StatelessWidget {
  final ConversationLesson lesson;

  const ConversationLessonPage({super.key, required this.lesson});

  Future<void> _completeLesson(BuildContext context) async {
    await UserProgressService().markLessonAsCompleted(lesson.id);
    if (context.mounted) {
      Navigator.pop(context, true); // Return true to signal completion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: lesson.vocabItems.isNotEmpty 
        ? _buildVocabList(context)
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            // Add 1 for the completion button at the end
            itemCount: lesson.lines.length + 1,
            itemBuilder: (context, index) {
              if (index == lesson.lines.length) {
                return _buildCompletionButton(context);
              }
              final line = lesson.lines[index];
              return _buildDialogueItem(line);
            },
          ),
    );
  }

  Widget _buildVocabList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lesson.vocabItems.length + 1,
      itemBuilder: (context, index) {
         if (index == lesson.vocabItems.length) {
            return _buildCompletionButton(context);
          }
          final item = lesson.vocabItems[index];
          return Card(
            elevation: 1,
             margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: item.kanji.isNotEmpty 
                ? CircleAvatar(child: Text(item.kanji, style: const TextStyle(fontSize: 12))) 
                : const Icon(Icons.abc),
              title: Text(item.kana, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(item.meaning),
              trailing: item.romaji.isNotEmpty ? Text(item.romaji) : null,
            ),
          );
      },
    );
  }

  Widget _buildCompletionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ElevatedButton.icon(
        onPressed: () => _completeLesson(context),
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('Hoàn thành bài học'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildDialogueItem(DialogueLine line) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  line.speaker.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                if (line.isQuiz)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'QUIZ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Basic display for now - can be improved to support furigana
            Text(
              line.kana,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              line.romaji,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              line.meaning,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

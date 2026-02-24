
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/flashcard_models.dart';
import '../datasources/local/vocab_data.dart';

class FlashcardRepository {
  static const String _storageKey = 'flashcard_sets';

  Future<List<FlashcardSet>> getFlashcardSets() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);
    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => FlashcardSet.fromJson(json)).toList();
  }

  Future<void> saveFlashcardSet(FlashcardSet set) async {
    final sets = await getFlashcardSets();
    // Check if updating existing
    final index = sets.indexWhere((s) => s.id == set.id);
    if (index >= 0) {
      sets[index] = set;
    } else {
      sets.add(set);
    }
    await _saveSets(sets);
  }

  Future<void> deleteFlashcardSet(String id) async {
    final sets = await getFlashcardSets();
    sets.removeWhere((s) => s.id == id);
    await _saveSets(sets);
  }

  /// Initialize default flashcards from vocab data
  Future<void> initializeDefaultFlashcards() async {
    final existingSets = await getFlashcardSets();
    
    // Only initialize if no flashcards exist yet
    if (existingSets.isNotEmpty) return;

    final List<FlashcardSet> defaultSets = [];

    // Convert each vocab lesson to a flashcard set
    for (final lesson in vocabLessonData) {
      if (lesson.vocabItems.isEmpty) continue;

      final List<Flashcard> cards = lesson.vocabItems.map((vocabItem) {
        // Build the front of the card (Japanese)
        String front = '';
        if (vocabItem.kanji != null && vocabItem.kanji!.isNotEmpty) {
          front = vocabItem.kanji!;
        } else if (vocabItem.kana != null && vocabItem.kana!.isNotEmpty) {
          front = vocabItem.kana!;
        }
        
        // Add reading if available
        if (vocabItem.kanji != null && 
            vocabItem.kanji!.isNotEmpty && 
            vocabItem.kana != null && 
            vocabItem.kana!.isNotEmpty) {
          front += '\n(${vocabItem.kana})';
        }
        
        // Add romaji if available
        if (vocabItem.romaji != null && vocabItem.romaji!.isNotEmpty) {
          front += '\n[${vocabItem.romaji}]';
        }

        // Build the back of the card (Vietnamese meaning)
        String back = vocabItem.meaning ?? '';

        return Flashcard(
          id: '${lesson.id}_${vocabItem.kana ?? vocabItem.kanji ?? ''}_${DateTime.now().millisecondsSinceEpoch}',
          front: front,
          back: back,
        );
      }).toList();

      defaultSets.add(FlashcardSet(
        id: 'vocab_${lesson.id}',
        title: lesson.title,
        cards: cards,
        masteredCount: 0,
        studiedCount: 0,
      ));
    }

    // Save all default sets
    await _saveSets(defaultSets);
  }

  Future<void> _saveSets(List<FlashcardSet> sets) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(sets.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }
}

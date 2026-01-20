
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/flashcard_models.dart';

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

  Future<void> _saveSets(List<FlashcardSet> sets) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(sets.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }
}

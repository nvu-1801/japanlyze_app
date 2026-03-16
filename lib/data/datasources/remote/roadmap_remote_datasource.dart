import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../domain/entities/roadmap_models.dart';

abstract class RoadmapRemoteDataSource {
  Future<List<RoadmapWeek>> getRoadmapByLevel(String jlptLevel);
}

class RoadmapRemoteDataSourceImpl implements RoadmapRemoteDataSource {
  final SupabaseClient _supabase;

  RoadmapRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  // In-memory cache for roadmap data
  final Map<String, List<RoadmapWeek>> _roadmapCache = {};

  void clearCache() => _roadmapCache.clear();

  @override
  Future<List<RoadmapWeek>> getRoadmapByLevel(String jlptLevel) async {
    try {
      // Check cache first
      if (_roadmapCache.containsKey(jlptLevel)) {
        return _roadmapCache[jlptLevel]!;
      }

      // Fetch roadmap data from Supabase
      final response = await _supabase
          .from('RoadmapWeeks')
          .select('*, quests:RoadmapQuests(*)')
          .eq('jlptLevel', jlptLevel)
          .order('week', ascending: true);

      if (response == null || (response as List).isEmpty) {
        throw ServerException('No roadmap data found for level $jlptLevel', 404);
      }

      final weeks = (response as List).map((weekJson) {
        final weekData = weekJson as Map<String, dynamic>;
        final questsData = weekData['quests'] as List?;
        
        final quests = questsData?.map((questJson) {
          final questData = questJson as Map<String, dynamic>;
          return RoadmapQuest(
            id: questData['id'] as String,
            title: questData['title'] as String,
            description: questData['description'] as String,
            type: questData['type'] as String,
            icon: _getIconFromString(questData['icon'] as String?),
            link: questData['link'] as String,
            xp: questData['xp'] as int,
          );
        }).toList() ?? [];

        return RoadmapWeek(
          week: weekData['week'] as int,
          title: weekData['title'] as String,
          description: weekData['description'] as String,
          color: Color(int.parse(weekData['color'] as String)),
          iconColor: Color(int.parse(weekData['iconColor'] as String)),
          badgeColor: Color(int.parse(weekData['badgeColor'] as String)),
          quests: quests,
        );
      }).toList();

      // Cache the result
      _roadmapCache[jlptLevel] = weeks;
      return weeks;
    } on PostgrestException catch (e) {
      throw ServerException(
        e.message,
        e.code != null ? int.tryParse(e.code!) ?? 500 : 500,
      );
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  IconData _getIconFromString(String? iconString) {
    if (iconString == null) return Icons.book_outlined;
    
    switch (iconString.toLowerCase()) {
      case 'book_outlined':
        return Icons.book_outlined;
      case 'visibility_outlined':
        return Icons.visibility_outlined;
      case 'edit_outlined':
        return Icons.edit_outlined;
      case 'emoji_events_outlined':
        return Icons.emoji_events_outlined;
      case 'school_outlined':
        return Icons.school_outlined;
      case 'quiz_outlined':
        return Icons.quiz_outlined;
      case 'headphones_outlined':
        return Icons.headphones_outlined;
      case 'mic_outlined':
        return Icons.mic_outlined;
      case 'translate_outlined':
        return Icons.translate_outlined;
      case 'auto_stories_outlined':
        return Icons.auto_stories_outlined;
      default:
        return Icons.book_outlined;
    }
  }
}

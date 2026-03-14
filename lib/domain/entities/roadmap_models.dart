import 'package:flutter/material.dart';

class RoadmapQuest {
  final String id;
  final String title;
  final String description;
  final String
  type; // 'learn', 'test', 'reading', 'flashcard', 'roleplay', 'community'
  final IconData icon;
  final String link;
  final int xp;

  const RoadmapQuest({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    required this.link,
    required this.xp,
  });
}

class RoadmapWeek {
  final int week;
  final String title;
  final String description;
  final Color color;
  final Color iconColor;
  final Color badgeColor;
  final List<RoadmapQuest> quests;

  const RoadmapWeek({
    required this.week,
    required this.title,
    required this.description,
    required this.color,
    required this.iconColor,
    required this.badgeColor,
    required this.quests,
  });
}

class RoadmapPhase {
  final int id;
  final String title;
  final String description;
  final String
  colorClass; // Storing the semantic color info for mobile adaptation
  final Color iconColor;
  final List<RoadmapQuest> quests;

  const RoadmapPhase({
    required this.id,
    required this.title,
    required this.description,
    required this.colorClass,
    required this.iconColor,
    required this.quests,
  });
}

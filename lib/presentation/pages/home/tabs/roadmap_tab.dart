import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/datasources/local/roadmap_data.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../../../data/services/user_progress_service.dart';
import '../../../../data/services/isar_service.dart';
import '../../../../domain/entities/roadmap_models.dart';
import '../../lesson/conversation_lesson_page.dart';
import '../../lesson/srs_flashcard_page.dart';
import 'roadmap/roadmap_utils.dart';
import 'roadmap/widgets/overall_progress_badge.dart';
import 'roadmap/widgets/overall_progress_bar.dart';
import 'roadmap/widgets/quest_card.dart';
import 'roadmap/widgets/week_header.dart';
import 'roadmap/widgets/week_tab.dart';

class RoadmapTab extends StatefulWidget {
  const RoadmapTab({super.key});

  @override
  State<RoadmapTab> createState() => _RoadmapTabState();
}

class _RoadmapTabState extends State<RoadmapTab> {
  int _selectedWeekIndex = 0;
  Set<String> _completedQuestIds = {};
  Map<String, double> _questProgress = {};
  bool _isLoadingProgress = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await IsarService.instance.initialize();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await UserProgressService().getCompletedLessons();
    final progress = await UserProgressService().getAllQuestProgress();
    if (mounted) {
      setState(() {
        _completedQuestIds = Set.from(completed);
        _questProgress = progress;
        _isLoadingProgress = false;
        _selectedWeekIndex = _calculateInitialWeekIndex();
      });
    }
  }

  int _calculateInitialWeekIndex() {
    // Tìm quest available gần nhất
    final nextIndex = RoadmapUtils.getNextAvailableQuestIndex(_completedQuestIds);
    if (nextIndex != -1) {
      final allQuests = n5Weeks.expand((w) => w.quests).toList();
      final quest = allQuests[nextIndex];
      for (int i = 0; i < n5Weeks.length; i++) {
        if (n5Weeks[i].quests.contains(quest)) {
          return i;
        }
      }
    }
    
    // Nếu không có, tìm week có completed quests gần nhất (từ cuối về đầu)
    for (int i = n5Weeks.length - 1; i >= 0; i--) {
      final weekQuests = n5Weeks[i].quests.map((q) => q.id).toSet();
      if (_completedQuestIds.intersection(weekQuests).isNotEmpty) {
        return i;
      }
    }
    
    return 0; // Default to week 1
  }

  void _onProgressUpdated() {
    _loadProgress();
  }

  Future<void> _navigateToQuest(RoadmapQuest quest) async {
    RoadmapQuest targetQuest = quest;

    if (RoadmapUtils.isQuestLocked(quest, _completedQuestIds)) {
      final targetIndex = RoadmapUtils.getNextAvailableQuestIndex(_completedQuestIds);
      if (targetIndex != -1) {
        final allQuests = n5Weeks.expand((w) => w.quests).toList();
        targetQuest = allQuests[targetIndex];
        if (!mounted) return;
        _showNavigationSnackBar(targetQuest.title);
      } else {
        return;
      }
    }

    final lessonId = RoadmapUtils.mapLinkToId(targetQuest.link);
    final lessonData = conversationData
        .where((c) => c.id == lessonId)
        .firstOrNull;

    if (lessonData != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _buildLessonPage(targetQuest, lessonData, _onProgressUpdated),
        ),
      );
      if (result == true) {
        _loadProgress();
      }
    } else {
      if (!mounted) return;
      _showDataNotReadySnackBar(quest.title);
    }
  }

  Widget _buildLessonPage(RoadmapQuest quest, dynamic lessonData, VoidCallback onProgressUpdated) {
    if (quest.type == 'flashcard') {
      return SRSFlashcardPage(lesson: lessonData, questId: quest.id, onProgressUpdated: onProgressUpdated);
    }
    return ConversationLessonPage(
      lesson: lessonData,
      questId: quest.id,
      onProgressUpdated: onProgressUpdated,
    );
  }

  void _showNavigationSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chuyển đến bài học kế tiếp: $title'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDataNotReadySnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dữ liệu bài học "$title" chưa sẵn sàng trên Mobile.'),
        backgroundColor: Colors.orange[800],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (n5Weeks.isEmpty) {
      return const Center(child: Text('Chưa có dữ liệu lộ trình.'));
    }

    final selectedWeek = n5Weeks[_selectedWeekIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _loadProgress,
        color: AppColors.primary,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(isDark),
            _buildWeekSelector(),
            _buildWeekContent(selectedWeek),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(bool isDark) {
    return SliverAppBar(
      expandedHeight: 160,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lộ trình N5 🗻',
                      style: GoogleFonts.lexend(
                        color: isDark ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                    ),
                    OverallProgressBadge(
                      completedQuestIds: _completedQuestIds,
                      isLoading: _isLoadingProgress,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                OverallProgressBar(completedQuestIds: _completedQuestIds),
                const SizedBox(height: 4),
                Text(
                  '11 tuần · Từ Zero đến Hero',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildWeekSelector() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Row(
          children: n5Weeks.asMap().entries.map((entry) {
            return WeekTab(
              weekNumber: entry.value.week,
              isSelected: _selectedWeekIndex == entry.key,
              iconColor: entry.value.iconColor,
              onTap: () => setState(() => _selectedWeekIndex = entry.key),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWeekContent(RoadmapWeek selectedWeek) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          WeekHeader(
            week: selectedWeek,
            completedQuestIds: _completedQuestIds,
          ),
          const SizedBox(height: 20),
          ...selectedWeek.quests.map(
            (quest) => QuestCard(
              quest: quest,
              week: selectedWeek,
              completedQuestIds: _completedQuestIds,
              progress: _questProgress[quest.id] ?? 0.0,
              onTap: () => _navigateToQuest(quest),
            ),
          ),
        ]),
      ),
    );
  }
}

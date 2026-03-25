import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/datasources/local/roadmap_data.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../../../data/datasources/remote/roadmap_remote_datasource.dart';
import '../../../../data/services/user_progress_service.dart';
import '../../../../data/services/isar_service.dart';
import '../../../../data/services/roadmap_sync_service.dart';
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
  String _selectedJlptLevel = 'N5';
  Set<String> _completedQuestIds = {};
  Map<String, double> _questProgress = {};
  bool _isLoadingProgress = true;
  bool _isLoadingRoadmap = true;
  late final RoadmapSyncService _syncService;
  late final RoadmapRemoteDataSource _roadmapDataSource;
  List<RoadmapWeek> _currentWeeks = [];

  final List<String> _jlptLevels = ['N5', 'N4', 'N3', 'N2', 'N1'];

  @override
  void initState() {
    super.initState();
    _syncService = GetIt.instance<RoadmapSyncService>();
    _roadmapDataSource = RoadmapRemoteDataSourceImpl(
      supabase: Supabase.instance.client,
    );
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await IsarService.instance.initialize();
    // Load saved level first
    await _loadCurrentJlptLevel();
    _loadRoadmap();
    _loadProgress();
  }

  Future<void> _loadRoadmap() async {
    try {
      final weeks = await _roadmapDataSource.getRoadmapByLevel(
        _selectedJlptLevel,
      );
      if (mounted) {
        setState(() {
          _currentWeeks = weeks;
          _isLoadingRoadmap = false;
          _selectedWeekIndex = 0;
        });
      }
    } catch (e) {
      print('Failed to load roadmap for level $_selectedJlptLevel: $e');
      // Fallback to local data based on level
      if (mounted) {
        setState(() {
          _currentWeeks = _getLocalRoadmapData(_selectedJlptLevel);
          _isLoadingRoadmap = false;
          _selectedWeekIndex = 0;
        });
      }
    }

    // Save current level to SharedPreferences for dashboard sync
    await _saveCurrentJlptLevel(_selectedJlptLevel);
  }

  List<RoadmapWeek> _getLocalRoadmapData(String level) {
    switch (level) {
      case 'N5':
        return n5Weeks;
      case 'N4':
        return n4Weeks;
      case 'N3':
        return n3Weeks;
      case 'N2':
        return n2Weeks;
      case 'N1':
        return n1Weeks;
      default:
        return n5Weeks;
    }
  }

  Future<void> _loadProgress({bool syncFromCloud = true}) async {
    // Sync from cloud if requested and user is authenticated
    if (syncFromCloud) {
      await _syncService.syncFromCloud();
    }

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
    if (_currentWeeks.isEmpty) return 0;

    // Tìm quest available gần nhất
    final nextIndex = RoadmapUtils.getNextAvailableQuestIndex(
      _completedQuestIds,
      _currentWeeks,
    );
    if (nextIndex != -1) {
      final allQuests = _currentWeeks.expand((w) => w.quests).toList();
      final quest = allQuests[nextIndex];
      for (int i = 0; i < _currentWeeks.length; i++) {
        if (_currentWeeks[i].quests.contains(quest)) {
          return i;
        }
      }
    }

    // Nếu không có, tìm week có completed quests gần nhất (từ cuối về đầu)
    for (int i = _currentWeeks.length - 1; i >= 0; i--) {
      final weekQuests = _currentWeeks[i].quests.map((q) => q.id).toSet();
      if (_completedQuestIds.intersection(weekQuests).isNotEmpty) {
        return i;
      }
    }

    return 0; // Default to week 1
  }

  void _onProgressUpdated() {
    _loadProgress(syncFromCloud: false);
  }

  Future<void> _navigateToQuest(RoadmapQuest quest) async {
    RoadmapQuest targetQuest = quest;

    if (RoadmapUtils.isQuestLocked(quest, _completedQuestIds, _currentWeeks)) {
      final targetIndex = RoadmapUtils.getNextAvailableQuestIndex(
        _completedQuestIds,
        _currentWeeks,
      );
      if (targetIndex != -1) {
        final allQuests = _currentWeeks.expand((w) => w.quests).toList();
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
          builder: (context) =>
              _buildLessonPage(targetQuest, lessonData, _onProgressUpdated),
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

  Widget _buildLessonPage(
    RoadmapQuest quest,
    dynamic lessonData,
    VoidCallback onProgressUpdated,
  ) {
    if (quest.type == 'flashcard') {
      return SRSFlashcardPage(
        lesson: lessonData,
        questId: quest.id,
        onProgressUpdated: onProgressUpdated,
      );
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

  Future<void> _saveCurrentJlptLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_jlpt_level', level);
  }

  Future<void> _loadCurrentJlptLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLevel = prefs.getString('current_jlpt_level');
    if (savedLevel != null && _jlptLevels.contains(savedLevel)) {
      _selectedJlptLevel = savedLevel;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingRoadmap) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentWeeks.isEmpty) {
      return const Center(child: Text('Chưa có dữ liệu lộ trình.'));
    }

    final selectedWeek = _currentWeeks[_selectedWeekIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          // Perform bidirectional sync on refresh
          await _syncService.bidirectionalSync();
          await _loadProgress(syncFromCloud: false);
        },
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
      expandedHeight: 270,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LỘ TRÌNH HỌC TẬP',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            color: isDark ? Colors.grey[400] : const Color(0xFF3F4A3C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lộ trình',
                          style: GoogleFonts.plusJakartaSans(
                            color: isDark ? Colors.white : const Color(0xFF191C1B),
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    _buildJlptLevelDropdown(isDark),
                  ],
                ),
                const SizedBox(height: 24),
                _buildProgressCard(isDark),
              ],
            ),
          ),
        ),
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildProgressCard(bool isDark) {
    if (_isLoadingProgress) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final totalQuests = RoadmapUtils.getTotalQuestCount(_currentWeeks);
    final completedCount = RoadmapUtils.getCompletedQuestCount(_completedQuestIds, _currentWeeks);
    final percentageInt = RoadmapUtils.calculateProgress(completedCount, totalQuests);
    final percentageDouble = totalQuests > 0 ? completedCount / totalQuests : 0.0;

    final bgColor = isDark ? Colors.grey[850] : const Color(0xFFF2F4F2);
    final borderColor = isDark ? Colors.grey[800]! : AppColors.primary.withValues(alpha: 0.15);
    final primaryColor = AppColors.primary;
    final tertiaryColor = isDark ? Colors.blue[300]! : const Color(0xFF0061A4);
    final tertiaryFixedColor = isDark ? Colors.blue[900]! : const Color(0xFFD1E4FF);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$percentageInt%',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedCount/$totalQuests nhiệm vụ hoàn thành',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[400] : const Color(0xFF3F4A3C),
                    ),
                  ),
                ],
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: tertiaryColor.withValues(alpha: 0.2),
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.flag,
                    color: tertiaryColor,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: tertiaryFixedColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentageDouble.clamp(0.01, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJlptLevelDropdown(bool isDark) {
    final bgColor = isDark ? Colors.grey[850] : const Color(0xFFF2F4F2);
    final borderColor = isDark ? Colors.grey[800]! : const Color(0xFFBECAB9).withValues(alpha: 0.15);
    final textColor = isDark ? Colors.white : const Color(0xFF191C1B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedJlptLevel,
          icon: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.expand_more,
              color: textColor,
              size: 20,
            ),
          ),
          isDense: true,
          style: GoogleFonts.manrope(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          dropdownColor: bgColor,
          borderRadius: BorderRadius.circular(16),
          items: _jlptLevels.map((String level) {
            return DropdownMenuItem<String>(
              value: level,
              child: Text(
                'Level $level',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedJlptLevel = newValue;
                _selectedWeekIndex = 0;
                _isLoadingRoadmap = true;
              });
              _loadRoadmap();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeekSelector() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: _currentWeeks.asMap().entries.map((entry) {
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
          WeekHeader(week: selectedWeek, completedQuestIds: _completedQuestIds),
          const SizedBox(height: 24),
          ...selectedWeek.quests.map(
            (quest) => QuestCard(
              quest: quest,
              week: selectedWeek,
              completedQuestIds: _completedQuestIds,
              progress: _questProgress[quest.id] ?? 0.0,
              onTap: () => _navigateToQuest(quest),
              weeks: _currentWeeks,
            ),
          ),
        ]),
      ),
    );
  }
}


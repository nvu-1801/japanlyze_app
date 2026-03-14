import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/datasources/local/roadmap_data.dart';
import '../../../../domain/entities/roadmap_models.dart';
import '../../../../data/services/user_progress_service.dart';
import '../../../../data/datasources/local/conversation_data.dart';
import '../../lesson/conversation_lesson_page.dart';
import '../../lesson/flashcard_page.dart';

class RoadmapTab extends StatefulWidget {
  const RoadmapTab({super.key});

  @override
  State<RoadmapTab> createState() => _RoadmapTabState();
}

class _RoadmapTabState extends State<RoadmapTab> {
  int _selectedWeekIndex = 0;
  Set<String> _completedQuestIds = {};
  bool _isLoadingProgress = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await UserProgressService().getCompletedLessons();
    if (mounted) {
      setState(() {
        _completedQuestIds = Set.from(completed);
        _isLoadingProgress = false;
      });
    }
  }

  String _mapLinkToId(String link) {
    if (link.contains('hiragana')) return 'hiragana';
    if (link.contains('katakana')) return 'katakana';

    final lessonMatch =
        RegExp(r'lesson=lesson(\d+)').firstMatch(link) ??
        RegExp(r'/lesson/(\d+)').firstMatch(link);
    if (lessonMatch != null) {
      final index = lessonMatch.group(1);
      switch (index) {
        case '1':
          return 'conv_1_intro';
        case '2':
          return 'conv_2_hometown';
        case '3':
          return 'conv_3_friends';
        case '4':
          return 'conv_4_subject';
        case '5':
          return 'conv_5_job';
      }
    }

    // Fallback: extract the last part of the path
    final parts = link.split('/');
    if (parts.isNotEmpty) {
      final last = parts.last;
      if (last.isNotEmpty) return last;
    }

    return link.replaceAll('/', '');
  }

  bool _isQuestLocked(RoadmapQuest quest) {
    final allQuests = n5Weeks.expand((w) => w.quests).toList();
    final index = allQuests.indexWhere((q) => q.id == quest.id);

    // Ensure the very first quest is always unlocked
    if (index <= 0) return false;

    // A quest is locked if the directly preceding quest is NOT completed
    final prevQuest = allQuests[index - 1];
    return !_completedQuestIds.contains(prevQuest.id);
  }

  Future<void> _navigateToQuest(RoadmapQuest quest) async {
    RoadmapQuest targetQuest = quest;

    if (_isQuestLocked(quest)) {
      final allQuests = n5Weeks.expand((w) => w.quests).toList();
      final targetIndex = allQuests.indexWhere(
        (q) => !_completedQuestIds.contains(q.id),
      );
      if (targetIndex != -1) {
        targetQuest = allQuests[targetIndex];
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chuyển đến bài học kế tiếp: ${targetQuest.title}'),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        return; // edge case: shouldn't happen if quest is locked
      }
    }

    final lessonId = _mapLinkToId(targetQuest.link);
    final lessonData = conversationData
        .where((c) => c.id == lessonId)
        .firstOrNull;

    if (lessonData != null) {
      Widget targetPage;
      if (targetQuest.type == 'flashcard') {
        targetPage = FlashcardPage(lesson: lessonData, questId: targetQuest.id);
      } else {
        targetPage = ConversationLessonPage(
          lesson: lessonData,
          questId: targetQuest.id,
        );
      }

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
      // Refresh progress if the lesson was completed
      if (result == true) {
        _loadProgress();
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dữ liệu bài học "${quest.title}" chưa sẵn sàng trên Mobile.',
          ),

          backgroundColor: Colors.orange[800],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (n5Weeks.isEmpty)
      return const Center(child: Text('Chưa có dữ liệu lộ trình.'));

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
            // App Bar with Overall Progress
            SliverAppBar(
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
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                            _buildOverallProgressBadge(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildOverallProgressBar(),
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
            ),

            // Week Selector (Horizontal)
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  children: n5Weeks.asMap().entries.map((entry) {
                    return _buildWeekTab(entry.key, entry.value);
                  }).toList(),
                ),
              ),
            ),

            // Week Detail and Quests
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildWeekHeader(selectedWeek),
                  const SizedBox(height: 20),
                  ...selectedWeek.quests.map(
                    (quest) => _buildQuestCard(quest, selectedWeek),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgressBadge() {
    if (_isLoadingProgress)
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );

    final totalQuests = n5Weeks.expand((w) => w.quests).length;
    // Map web links to IDs for matching with _completedQuestIds
    final questIdsInRoadmap = n5Weeks
        .expand((w) => w.quests)
        .map((q) => q.id)
        .toSet();
    final completedCount = _completedQuestIds
        .intersection(questIdsInRoadmap)
        .length;

    final percentage = totalQuests > 0
        ? (completedCount / totalQuests * 100).round()
        : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$percentage%',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: AppColors.primary,
          ),
        ),
        Text(
          '$completedCount/$totalQuests nhiệm vụ',
          style: GoogleFonts.lexend(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildOverallProgressBar() {
    final totalQuests = n5Weeks.expand((w) => w.quests).length;
    final questIdsInRoadmap = n5Weeks
        .expand((w) => w.quests)
        .map((q) => q.id)
        .toSet();
    final completedCount = _completedQuestIds
        .intersection(questIdsInRoadmap)
        .length;
    final percentage = totalQuests > 0 ? completedCount / totalQuests : 0.0;

    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage.clamp(0.01, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekTab(int index, RoadmapWeek week) {
    final isSelected = _selectedWeekIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _selectedWeekIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? week.iconColor
              : (isDark ? Colors.white.withOpacity(0.05) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: week.iconColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(
              '${week.week}',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
            Text(
              'Tuần',
              style: GoogleFonts.lexend(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white.withOpacity(0.8)
                    : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekHeader(RoadmapWeek week) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final weekQuestIds = week.quests.map((q) => q.id).toSet();
    final completedCount = _completedQuestIds.intersection(weekQuestIds).length;
    final totalCount = week.quests.length;
    final percentage = totalCount > 0
        ? (completedCount / totalCount * 100).round()
        : 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: week.color.withOpacity(isDark ? 0.1 : 1.0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: week.iconColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: week.iconColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: week.iconColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week.title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: isDark ? Colors.white : Colors.blueGrey[800],
                  ),
                ),
                Text(
                  week.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                '$percentage%',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: week.iconColor,
                ),
              ),
              Text(
                '$completedCount/$totalCount',
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestCard(RoadmapQuest quest, RoadmapWeek week) {
    // Map web links to IDs for matching with _completedQuestIds
    final isDone = _completedQuestIds.contains(quest.id);
    final isLocked = _isQuestLocked(quest);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isLocked
            ? (isDark ? Colors.white.withOpacity(0.02) : Colors.grey[100])
            : isDone
            ? (isDark ? Colors.green.withOpacity(0.1) : Colors.green[50])
            : (isDark ? Colors.white.withOpacity(0.04) : Colors.white),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLocked
              ? (isDark ? Colors.transparent : Colors.grey[200]!)
              : isDone
              ? Colors.green.withOpacity(0.3)
              : (isDark ? Colors.white.withOpacity(0.08) : Colors.grey[100]!),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLocked
                ? () => _navigateToQuest(quest)
                : () => _navigateToQuest(quest),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.grey.withOpacity(0.3)
                              : week.color.withOpacity(isDark ? 0.2 : 0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isLocked ? Icons.lock_rounded : quest.icon,
                          color: isLocked ? Colors.grey[600] : week.iconColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quest.title,
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isLocked
                                    ? Colors.grey[500]
                                    : isDone
                                    ? Colors.green[700]
                                    : (isDark
                                          ? Colors.white
                                          : Colors.blueGrey[800]),
                              ),
                            ),
                            Text(
                              quest.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: isLocked
                                    ? Colors.grey[500]
                                    : isDark
                                    ? Colors.white38
                                    : Colors.grey[500],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isLocked
                            ? Icons.lock_outline
                            : isDone
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isLocked
                            ? Colors.grey[400]
                            : isDone
                            ? Colors.green
                            : Colors.grey[300],
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.grey.withOpacity(0.1)
                              : isDone
                              ? Colors.green.withOpacity(0.1)
                              : (isDark ? Colors.white10 : Colors.grey[100]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isDone ? '✓ Hoàn thành' : '+${quest.xp} XP',
                          style: GoogleFonts.lexend(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isLocked
                                ? Colors.grey[500]
                                : isDone
                                ? Colors.green[700]
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                      if (!isLocked) ...[
                        Row(
                          children: [
                            Text(
                              isDone ? 'Học lại' : 'Vào học',
                              style: GoogleFonts.lexend(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isDone
                                    ? Colors.green
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              size: 14,
                              color: isDone ? Colors.green : AppColors.primary,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

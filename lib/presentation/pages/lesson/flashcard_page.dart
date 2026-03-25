import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/conversation_models.dart';
import '../../../domain/entities/flashcard_models.dart';
import '../../../data/services/user_progress_service.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../../data/services/isar_service.dart';
import '../settings_page.dart';
import 'vocab_practice_page.dart';

class FlashcardPage extends StatefulWidget {
  final ConversationLesson lesson;
  final String? questId;
  final VoidCallback? onProgressUpdated;

  const FlashcardPage({
    super.key,
    required this.lesson,
    this.questId,
    this.onProgressUpdated,
  });

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with TickerProviderStateMixin {
  // Midnight Scholar Colors (Dark)
  static const Color midnightBg = Color(0xFF101922);
  static const Color midnightSurface = Color(0xFF1a2632);
  static const Color midnightSurfaceVariant = Color(0xFF253441);
  static const Color midnightOutline = Color(0xFF334155);
  static const Color midnightPrimary = AppColors.primary;
  static const Color midnightSecondary = Color(0xFF92adc9);
  static const Color midnightOnSurface = Color(0xFFf1f5f9);
  static const Color midnightOnSurfaceVariant = Color(0xFF94a3b8);

  // Light Scholar Colors (Light)
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightOutline = Color(0xFFE2E8F0);
  static const Color lightPrimary = AppColors.primary;
  static const Color lightSecondary = Color(0xFF64748B);
  static const Color lightOnSurface = Color(0xFF0F172A);
  static const Color lightOnSurfaceVariant = Color(0xFF475569);

  // Theme-aware color getters
  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _bg => _isDark ? midnightBg : lightBg;
  Color get _surface => _isDark ? midnightSurface : lightSurface;
  Color get _surfaceVariant =>
      _isDark ? midnightSurfaceVariant : lightSurfaceVariant;
  Color get _outline => _isDark ? midnightOutline : lightOutline;
  Color get _primary => _isDark ? midnightPrimary : lightPrimary;
  Color get _secondary => _isDark ? midnightSecondary : lightSecondary;
  Color get _onSurface => _isDark ? midnightOnSurface : lightOnSurface;
  Color get _onSurfaceVariant =>
      _isDark ? midnightOnSurfaceVariant : lightOnSurfaceVariant;

  late PageController _pageController;
  int _currentIndex = 0;
  bool _isFlipped = false;
  bool _isLoading = true;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  // Tracking learned status for this session
  Set<int> _learnedIndices = {};
  Set<int> _unlearnedIndices = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );

    _initializeRepository();
  }

  late FlashcardRepository _flashcardRepository;

  void _initializeRepository() async {
    final isar = IsarService.instance.isar;
    _flashcardRepository = FlashcardRepository(isar);

    // IMPORTANT: Create flashcards in Isar so they can be tracked by SRS
    await _flashcardRepository.createFlashcardsFromVocab(
      questId: widget.questId ?? widget.lesson.id,
      vocabItems: widget.lesson.vocabItems,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    });
  }

  void _onReview(FlashcardRating rating) async {
    if (_isLoading) return; // Wait for initialization

    final bool isLearned = rating != FlashcardRating.hard;
    if (isLearned) {
      _learnedIndices.add(_currentIndex);
    } else {
      _unlearnedIndices.add(_currentIndex);
    }

    // Persist SRS rating
    final cardId = '${widget.questId ?? widget.lesson.id}_card_$_currentIndex';

    await _flashcardRepository.updateFlashcardReview(
      cardId: cardId,
      rating: rating,
    );

    // Update progress
    _updateProgress();
    widget.onProgressUpdated?.call();

    if (_currentIndex < widget.lesson.vocabItems.length - 1) {
      setState(() {
        _isFlipped = false;
        _flipController.reset();
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showSummary();
    }
  }

  void _updateProgress() {
    final total = widget.lesson.vocabItems.length;
    if (total > 0 && widget.questId != null) {
      final progress = (_currentIndex + 1) / total;
      UserProgressService().updateQuestProgress(widget.questId!, progress);
    }
  }

  Future<void> _showSummary() async {
    final total = widget.lesson.vocabItems.length;
    final learned = _learnedIndices.length;

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Kết quả luyện tập! 🎉',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bạn đã thuộc $learned/$total từ vựng trong bộ này.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentIndex = 0;
                        _learnedIndices.clear();
                        _unlearnedIndices.clear();
                        _isFlipped = false;
                        _flipController.reset();
                      });
                      _pageController.jumpToPage(0);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Học lại'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close bottom sheet
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VocabPracticePage(
                            lesson: widget.lesson,
                            questId: widget.questId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Làm bài tập'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: _bg,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final vocab = widget.lesson.vocabItems;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.menu, color: _onSurfaceVariant),
        ),
        title: Text(
          widget.lesson.title,
          style: GoogleFonts.plusJakartaSans(
            color: _onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: _onSurfaceVariant),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vocab Practice',
                      style: GoogleFonts.plusJakartaSans(
                        color: _primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '${_currentIndex + 1}/${vocab.length}',
                      style: GoogleFonts.plusJakartaSans(
                        color: _onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _surfaceVariant,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (_currentIndex + 1) / vocab.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: _primary.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vocab.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: GestureDetector(
                      onTap: _toggleFlip,
                      child: AnimatedBuilder(
                        animation: _flipAnimation,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_flipAnimation.value),
                            alignment: Alignment.center,
                            child: _flipAnimation.value < pi / 2
                                ? _buildCardFront(vocab[index], isDark)
                                : Transform(
                                    transform: Matrix4.identity()..rotateY(pi),
                                    alignment: Alignment.center,
                                    child: _buildCardBack(vocab[index], isDark),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom section buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onReview(FlashcardRating.hard),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: _surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Chưa thuộc',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onReview(FlashcardRating.good),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _primary.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Đã thuộc',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFront(VocabItem item, bool isDark) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: _outline.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: _isDark ? 0.4 : 0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.kanji.isNotEmpty ? item.kanji : item.kana,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: _onSurface,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          if (item.kanji.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.kana,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                color: _secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 48),
          Text(
            'Chạm để lật thẻ',
            style: GoogleFonts.plusJakartaSans(
              color: _primary.withValues(alpha: 0.6),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(VocabItem item, bool isDark) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: _outline.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: _isDark ? 0.4 : 0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'BACK VIEW',
                  style: GoogleFonts.plusJakartaSans(
                    color: _primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                item.kanji.isNotEmpty ? item.kanji : item.kana,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: _onSurface,
                  letterSpacing: -1,
                ),
              ),
              Text(
                item.meaning,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: _secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 24),
              // Meaning Detail Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _primary.withValues(alpha: 0.1)),
                ),
                child: Text(
                  item.romaji,
                  style: GoogleFonts.plusJakartaSans(
                    color: _onSurface,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Difficulty buttons inside the card back
              Row(
                children: [
                  Expanded(
                    child: _buildReviewButton(
                      label: 'Hard',
                      time: '1d',
                      color: Colors.red,
                      onTap: () => _onReview(FlashcardRating.hard),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildReviewButton(
                      label: 'Good',
                      time: '3d',
                      color: _primary,
                      onTap: () => _onReview(FlashcardRating.good),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildReviewButton(
                      label: 'Easy',
                      time: '7d',
                      color: Colors.green,
                      onTap: () => _onReview(FlashcardRating.easy),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewButton({
    required String label,
    required String time,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _outline.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.plusJakartaSans(
                color: _onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

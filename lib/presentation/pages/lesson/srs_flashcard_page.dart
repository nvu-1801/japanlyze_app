import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../../data/services/isar_service.dart';
import '../../../domain/entities/conversation_models.dart';
import '../../../domain/entities/flashcard_models.dart';
import '../../../data/services/user_progress_service.dart';
import '../settings_page.dart';

/// SRS Flashcard Page with swipe gestures and 3D flip animation
class SRSFlashcardPage extends StatefulWidget {
  final ConversationLesson? lesson;
  final String? questId;
  final String? title;
  final List<FlashcardItem>? initialCards;
  final VoidCallback? onProgressUpdated;

  const SRSFlashcardPage({
    super.key,
    this.lesson,
    this.questId,
    this.title,
    this.initialCards,
    this.onProgressUpdated,
  });

  @override
  State<SRSFlashcardPage> createState() => _SRSFlashcardPageState();
}

class _SRSFlashcardPageState extends State<SRSFlashcardPage>
    with TickerProviderStateMixin {
  // Midnight Scholar Colors (Dark)
  static const Color midnightBg = Color(0xFF101922);
  static const Color midnightSurfaceVariant = Color(0xFF253441);
  static const Color midnightOutline = Color(0xFF334155);
  static const Color midnightPrimary = AppColors.primary;
  static const Color midnightOnSurface = Color(0xFFf1f5f9);
  static const Color midnightOnSurfaceVariant = Color(0xFF94a3b8);

  // Light Scholar Colors (Light)
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightOutline = Color(0xFFE2E8F0);
  static const Color lightPrimary = AppColors.primary;
  static const Color lightOnSurface = Color(0xFF0F172A);
  static const Color lightOnSurfaceVariant = Color(0xFF475569);

  // Theme-aware color getters
  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _bg => _isDark ? midnightBg : lightBg;
  Color get _surfaceVariant =>
      _isDark ? midnightSurfaceVariant : lightSurfaceVariant;
  Color get _outline => _isDark ? midnightOutline : lightOutline;
  Color get _primary => _isDark ? midnightPrimary : lightPrimary;
  Color get _onSurface => _isDark ? midnightOnSurface : lightOnSurface;
  Color get _onSurfaceVariant =>
      _isDark ? midnightOnSurfaceVariant : lightOnSurfaceVariant;

  List<FlashcardItem> _flashcards = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  // Session tracking
  int _correctCount = 0;
  int _incorrectCount = 0;
  DateTime _sessionStart = DateTime.now();

  late FlashcardRepository _flashcardRepository;

  @override
  void initState() {
    super.initState();
    _initializeFlashcards();
  }

  Future<void> _initializeFlashcards() async {
    final isar = IsarService.instance.isar;
    _flashcardRepository = FlashcardRepository(isar);

    if (widget.initialCards != null) {
      if (mounted) {
        setState(() {
          _flashcards = widget.initialCards!;
          _isLoading = false;
        });
      }
      return;
    }

    if (widget.lesson == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    // Create flashcards from vocab if not exists
    await _flashcardRepository.createFlashcardsFromVocab(
      questId: widget.questId ?? widget.lesson!.id,
      vocabItems: widget.lesson!.vocabItems,
    );

    // Get flashcards for this quest
    final cards = await _flashcardRepository.getFlashcardsForQuest(
      widget.questId ?? widget.lesson!.id,
    );

    if (mounted) {
      setState(() {
        _flashcards = cards;
        _isLoading = false;
      });
    }
  }

  bool _isProcessing = false;

  void _onReview(FlashcardRating rating) async {
    if (_flashcards.isEmpty) return;
    if (_currentIndex >= _flashcards.length) return;
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    final currentCard = _flashcards[_currentIndex];

    // Update SRS data
    await _flashcardRepository.updateFlashcardReview(
      cardId: currentCard.cardId,
      rating: rating,
    );

    // Track session progress
    if (rating != FlashcardRating.hard) {
      _correctCount++;
    } else {
      _incorrectCount++;
    }

    // Update progress in database
    final qId = widget.questId ?? widget.lesson?.id;
    if (qId != null) {
      final progress = (_currentIndex + 1) / _flashcards.length;
      await UserProgressService().updateQuestProgress(qId, progress);
    }

    // Always notify progress update (e.g., for dashboard counts)
    widget.onProgressUpdated?.call();

    // Animation transition to next card or summary
    HapticFeedback.mediumImpact();

    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _finalizeSession();
    }

    // Brief cooldown to avoid double taps
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _finalizeSession() async {
    final total = _flashcards.length;
    final duration = DateTime.now().difference(_sessionStart).inSeconds;
    final progress = _correctCount / total;
    final xpEarned = (_correctCount * 10).toInt();

    // Save progress history
    final history = UserProgressHistory.create(
      historyId:
          '${widget.questId ?? widget.lesson?.id ?? "srs_bucket"}_${DateTime.now().millisecondsSinceEpoch}',
      questId: widget.questId ?? widget.lesson?.id ?? 'srs_bucket',
      sessionType: 'flashcard',
      itemsReviewed: total,
      correctAnswers: _correctCount,
      incorrectAnswers: _incorrectCount,
      durationSeconds: duration,
      progress: progress,
      isCompleted: progress >= 0.8, // 80% mastery
      xpEarned: xpEarned,
    );
    await _flashcardRepository.saveProgressHistory(history);

    // Mark quest as completed if 80% mastery
    if (progress >= 0.8 && widget.questId != null) {
      await UserProgressService().markLessonAsCompleted(widget.questId!);
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: _onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_flashcards.isEmpty) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: _onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.style_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Không có thẻ nào để học',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: _onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title ?? widget.lesson?.title ?? 'Flashcards',
          style: GoogleFonts.plusJakartaSans(
            color: _onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'JLPT Vocabulary SRS',
                        style: GoogleFonts.plusJakartaSans(
                          color: _primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        '${_currentIndex + 1}/${_flashcards.length}',
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
                      widthFactor: (_currentIndex + 1) / _flashcards.length,
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

            // Flashcard Transition
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.2, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _currentIndex < _flashcards.length
                    ? _SrsFlashcardItem(
                        key: ValueKey(_flashcards[_currentIndex].cardId),
                        card: _flashcards[_currentIndex],
                        isDark: _isDark,
                        onReview: _onReview,
                        isTop: true,
                      )
                    : const SizedBox.shrink(),
              ),
            ),

            // Bottom section buttons - Quick access from front
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
                              'Chưa nhớ',
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
                              'Đã nhớ',
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
      ),
    );
  }
}

class _SrsFlashcardItem extends StatefulWidget {
  final FlashcardItem card;
  final bool isDark;
  final Function(FlashcardRating) onReview;
  final bool isTop;

  const _SrsFlashcardItem({
    super.key,
    required this.card,
    required this.isDark,
    required this.onReview,
    required this.isTop,
  });

  @override
  State<_SrsFlashcardItem> createState() => _SrsFlashcardItemState();
}

class _SrsFlashcardItemState extends State<_SrsFlashcardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (!widget.isTop) return;
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _flipController.forward();
        HapticFeedback.lightImpact();
      } else {
        _flipController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Theme colors locally
    final surface = widget.isDark
        ? const Color(0xFF1a2632)
        : const Color(0xFFFFFFFF);
    final outline = widget.isDark
        ? const Color(0xFF334155)
        : const Color(0xFFE2E8F0);
    final onSurface = widget.isDark
        ? const Color(0xFFf1f5f9)
        : const Color(0xFF0F172A);
    final primary = AppColors.primary;
    final secondary = widget.isDark
        ? const Color(0xFF92adc9)
        : const Color(0xFF64748B);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            final isShowingBack = _flipAnimation.value > (pi / 2);
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_flipAnimation.value)
                ..setEntry(3, 2, 0.001),
              child: GestureDetector(
                onTap: _toggleFlip,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: widget.isDark ? 0.4 : 0.05,
                        ),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: isShowingBack
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: _buildCardBack(
                            widget.card,
                            surface,
                            onSurface,
                            primary,
                            secondary,
                            outline,
                          ),
                        )
                      : _buildCardFront(
                          widget.card,
                          surface,
                          onSurface,
                          primary,
                          secondary,
                          outline,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFront(
    FlashcardItem card,
    Color surface,
    Color onSurface,
    Color primary,
    Color secondary,
    Color outline,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.meaning,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Chạm để xem đáp án',
          style: GoogleFonts.plusJakartaSans(
            color: onSurface.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 48),
        Text(
          'Chạm để lật thẻ',
          style: GoogleFonts.plusJakartaSans(
            color: primary.withValues(alpha: 0.6),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildCardBack(
    FlashcardItem card,
    Color surface,
    Color onSurface,
    Color primary,
    Color secondary,
    Color outline,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'BACK VIEW',
                style: GoogleFonts.plusJakartaSans(
                  color: primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              card.japanese,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: onSurface,
                letterSpacing: -1,
              ),
            ),
            if (card.kana != card.japanese)
              Text(
                card.kana,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  color: secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              card.meaning,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primary.withValues(alpha: 0.1)),
              ),
              child: Text(
                card.romaji,
                style: GoogleFonts.plusJakartaSans(
                  color: onSurface,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildReviewButton(
                    label: 'Khó',
                    time: '< 15m',
                    color: Colors.red,
                    outline: outline,
                    onTap: () => widget.onReview(FlashcardRating.hard),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildReviewButton(
                    label: 'Tốt',
                    time: '< 5h',
                    color: primary,
                    outline: outline,
                    onTap: () => widget.onReview(FlashcardRating.good),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildReviewButton(
                    label: 'Dễ',
                    time: '1d+',
                    color: Colors.green,
                    outline: outline,
                    onTap: () => widget.onReview(FlashcardRating.easy),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewButton({
    required String label,
    required String time,
    required Color color,
    required Color outline,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              (widget.isDark
                      ? const Color(0xFF253441)
                      : const Color(0xFFF1F5F9))
                  .withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: outline.withValues(alpha: 0.2)),
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
                color: widget.isDark ? Colors.white70 : Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

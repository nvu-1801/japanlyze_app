import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../../data/services/isar_service.dart';
import '../../../domain/entities/conversation_models.dart';
import '../../../domain/entities/flashcard_models.dart';
import '../../../data/services/user_progress_service.dart';

/// SRS Flashcard Page with swipe gestures and 3D flip animation
class SRSFlashcardPage extends StatefulWidget {
  final ConversationLesson lesson;
  final String? questId;

  const SRSFlashcardPage({
    super.key,
    required this.lesson,
    this.questId,
  });

  @override
  State<SRSFlashcardPage> createState() => _SRSFlashcardPageState();
}

class _SRSFlashcardPageState extends State<SRSFlashcardPage>
    with TickerProviderStateMixin {
  late AppinioSwiperController _swiperController;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  
  List<FlashcardItem> _flashcards = [];
  int _currentIndex = 0;
  bool _isFlipped = false;
  bool _isLoading = true;
  
  // Session tracking
  int _correctCount = 0;
  int _incorrectCount = 0;
  DateTime _sessionStart = DateTime.now();
  
  late FlashcardRepository _flashcardRepository;

  @override
  void initState() {
    super.initState();
    _swiperController = AppinioSwiperController();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    
    _initializeFlashcards();
  }

  Future<void> _initializeFlashcards() async {
    final isar = IsarService.instance.isar;
    _flashcardRepository = FlashcardRepository(isar);
    
    // Create flashcards from vocab if not exists
    await _flashcardRepository.createFlashcardsFromVocab(
      questId: widget.questId ?? widget.lesson.id,
      vocabItems: widget.lesson.vocabItems,
    );
    
    // Get flashcards for this quest
    final cards = await _flashcardRepository.getFlashcardsForQuest(
      widget.questId ?? widget.lesson.id,
    );
    
    if (mounted) {
      setState(() {
        _flashcards = cards;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _swiperController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
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

  void _onSwipe(bool remembered) async {
    if (_flashcards.isEmpty) return;
    
    final currentCard = _flashcards[_currentIndex];
    
    // Update SRS data
    await _flashcardRepository.updateFlashcardReview(
      cardId: currentCard.cardId,
      remembered: remembered,
    );
    
    // Track session
    if (remembered) {
      _correctCount++;
    } else {
      _incorrectCount++;
    }
    
    // Update progress
    if (widget.questId != null) {
      final progress = (_currentIndex + 1) / _flashcards.length;
      await UserProgressService().updateQuestProgress(widget.questId!, progress);
    }
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    // Move to next card or show summary
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _isFlipped = false;
        _flipController.reset();
        _currentIndex++;
      });
      _swiperController.swipeRight();
    } else {
      _showSummary();
    }
  }

  Future<void> _showSummary() async {
    final total = _flashcards.length;
    final duration = DateTime.now().difference(_sessionStart).inSeconds;
    final progress = _correctCount / total;
    final xpEarned = (_correctCount * 10).toInt();
    
    // Save progress history
    final history = UserProgressHistory.create(
      historyId: '${widget.questId}_${DateTime.now().millisecondsSinceEpoch}',
      questId: widget.questId ?? widget.lesson.id,
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
              child: Icon(
                progress >= 0.8 ? Icons.emoji_events_rounded : Icons.school_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              progress >= 0.8 ? 'Hoàn thành xuất sắc! 🎉' : 'Kết quả luyện tập',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bạn đã thuộc $_correctCount/$total từ vựng trong bộ này.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '+$xpEarned XP',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
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
                        _correctCount = 0;
                        _incorrectCount = 0;
                        _isFlipped = false;
                        _flipController.reset();
                        _sessionStart = DateTime.now();
                      });
                      // Reset manually
                      setState(() {
                        _currentIndex = 0;
                      });
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
                      Navigator.pop(context);
                      Navigator.pop(context, true);
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
                    child: const Text('Tiếp tục'),
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
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9FAFB),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
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
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9FAFB),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.style_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
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

    final currentCard = _flashcards[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.lesson.title,
          style: GoogleFonts.lexend(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${_flashcards.length}',
                style: GoogleFonts.lexend(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _flashcards.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 8,
                ),
              ),
            ),
            
            // Flashcard
            Expanded(
              child: Center(
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 30,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: isShowingBack
                                ? _buildCardBack(currentCard)
                                : _buildCardFront(currentCard),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            
            // Swipe buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSwipeButton(
                      icon: Icons.close_rounded,
                      label: 'Chưa nhớ',
                      color: Colors.red,
                      onTap: () => _onSwipe(false),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSwipeButton(
                      icon: Icons.check_rounded,
                      label: 'Đã nhớ',
                      color: Colors.green,
                      onTap: () => _onSwipe(true),
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

  Widget _buildCardFront(FlashcardItem card) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.japanese,
            style: GoogleFonts.lexend(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          if (card.kana != card.japanese) ...[
            const SizedBox(height: 16),
            Text(
              card.kana,
              style: GoogleFonts.lexend(
                fontSize: 28,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 32),
          Icon(
            Icons.touch_app_rounded,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'Chạm để lật thẻ',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(FlashcardItem card) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.meaning,
            style: GoogleFonts.lexend(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (card.romaji.isNotEmpty) ...[
            Text(
              card.romaji,
              style: GoogleFonts.lexend(
                fontSize: 20,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
          if (card.example != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    card.example!,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (card.exampleMeaning != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      card.exampleMeaning!,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSwipeButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/conversation_models.dart';
import '../../../data/services/user_progress_service.dart';
import 'vocab_practice_page.dart';

class FlashcardPage extends StatefulWidget {
  final ConversationLesson lesson;
  final String? questId;
  const FlashcardPage({super.key, required this.lesson, this.questId});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isFlipped = false;
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

  void _onSwipe(bool isLearned) {
    if (isLearned) {
      _learnedIndices.add(_currentIndex);
    } else {
      _unlearnedIndices.add(_currentIndex);
    }

    // Update progress
    _updateProgress();

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
                color: AppColors.primary.withOpacity(0.1),
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
    final vocab = widget.lesson.vocabItems;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : AppColors.textPrimary,
            size: 20,
          ),
        ),
        title: Column(
          children: [
            Text(
              widget.lesson.title,
              style: GoogleFonts.lexend(
                color: isDark ? Colors.white : AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_currentIndex + 1}/${vocab.length} thẻ',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / vocab.length,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                minHeight: 6,
              ),
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

          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  onTap: () => _onSwipe(false),
                  icon: Icons.close_rounded,
                  color: Colors.red,
                  label: 'Chưa thuộc',
                ),
                _buildActionButton(
                  onTap: () => _onSwipe(true),
                  icon: Icons.check_rounded,
                  color: Colors.green,
                  label: 'Đã thuộc',
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
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.kanji.isNotEmpty)
                Text(
                  item.kanji,
                  style: GoogleFonts.notoSansJp(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                item.kana,
                style: GoogleFonts.lexend(
                  fontSize: 32,
                  color: item.kanji.isNotEmpty
                      ? Colors.grey[500]
                      : (isDark ? Colors.white : AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'Chạm để xem nghĩa',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack(VocabItem item, bool isDark) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.translate_rounded,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 24),
              Text(
                item.meaning,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item.romaji,
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  color: Colors.grey[500],
                ),
              ),
              if (item.note != null && item.note!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    item.note!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

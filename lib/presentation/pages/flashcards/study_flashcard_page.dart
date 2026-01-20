
import 'package:flutter/material.dart';
import '../../../../infrastructure/repositories/flashcard_repository.dart';
import '../../../../domain/entities/flashcard_models.dart';
import '../../../../core/constants/app_colors.dart';
import 'dart:math' as math;

class StudyFlashcardPage extends StatefulWidget {
  final FlashcardSet flashcardSet;

  const StudyFlashcardPage({super.key, required this.flashcardSet});

  @override
  State<StudyFlashcardPage> createState() => _StudyFlashcardPageState();
}

class _StudyFlashcardPageState extends State<StudyFlashcardPage> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _flipCard() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  void _nextCard() {
    if (_currentIndex < widget.flashcardSet.cards.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        // Save progress
        final currentProgress = widget.flashcardSet.studiedCount;
        final newProgress = math.max(currentProgress, _currentIndex + 1);
        
        if (newProgress > currentProgress) {
           final updatedSet = FlashcardSet(
            id: widget.flashcardSet.id,
            title: widget.flashcardSet.title,
            cards: widget.flashcardSet.cards,
            masteredCount: widget.flashcardSet.masteredCount,
            studiedCount: newProgress,
          );
          await FlashcardRepository().saveFlashcardSet(updatedSet);
        }

        if (context.mounted) {
          Navigator.pop(context, true); // Return true to trigger reload
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.flashcardSet.title),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.flashcardSet.cards.length,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
            Text(
              '${_currentIndex + 1} / ${widget.flashcardSet.cards.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.flashcardSet.cards.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _showFront = true; // Reset flip on swipe
                  });
                },
                itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(24.0),
                   child: _buildFlipCard(widget.flashcardSet.cards[index]),
                 );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _currentIndex > 0 ? _prevCard : null,
                    icon: const Icon(Icons.arrow_back_ios, size: 32),
                  ),
                  IconButton(
                     onPressed: _currentIndex < widget.flashcardSet.cards.length - 1 ? _nextCard : null,
                    icon: const Icon(Icons.arrow_forward_ios, size: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipCard(Flashcard card) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (Widget child, Animation<double> animation) {
           final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotateAnim,
              child: child,
              builder: (context, child) {
                final isUnder = (ValueKey(_showFront) != child!.key);
                var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                tilt *= isUnder ? -1.0 : 1.0;
                final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
                return Transform(
                  transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                  alignment: Alignment.center,
                  child: child,
                );
              },
            );
        },
        layoutBuilder: (widget, list) => Stack(children: [if(widget != null) widget, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFront 
            ? _buildCardFace(key: const ValueKey(true), text: card.front, label: "Front")
            : _buildCardFace(key: const ValueKey(false), text: card.back, label: "Back"),
      ),
    );
  }
  
  // Custom simple Flip without 3D for robustness first time, or stick to Switcher? 
  // The AnimatedSwitcher above with Matrix4 is complex to get right without packages.
  // Let's use a simpler standard AnimatedSwitcher for "Fade/Scale" or just simple Switcher first.
  // Actually, standard Quizlet flip is nice. Let's do a simple Container swap first to ensure it works, then polish.
  // User asked for "flip card". I'll use a standard implementation.
  
  Widget _buildCardFace({required Key key, required String text, required String label}) {
     return Container(
       key: key,
       width: double.infinity,
       height: double.infinity,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(24),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.1),
             blurRadius: 10,
             offset: const Offset(0, 5),
           )
         ],
       ),
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               text,
               textAlign: TextAlign.center,
               style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 16),
             Text(
               label,
               style: TextStyle(color: Colors.grey[400], fontSize: 14),
             ),
             const SizedBox(height: 48),
             Icon(Icons.touch_app, color: Colors.grey[300]),
             Text("Tap to flip", style: TextStyle(color: Colors.grey[300], fontSize: 12)),
           ],
         ),
       ),
     );
  }
  
  double get pi => math.pi;
  double min(double a, double b) => math.min(a,b);
}

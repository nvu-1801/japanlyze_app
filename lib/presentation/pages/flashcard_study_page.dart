import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/constants/app_colors.dart';
import '../../domain/entities/card.dart' as fc;

/// Flashcard study page with flip animation
class FlashcardStudyPage extends StatefulWidget {
  final List<fc.Card> cards;
  final String deckTitle;

  const FlashcardStudyPage({
    super.key,
    required this.cards,
    required this.deckTitle,
  });

  @override
  State<FlashcardStudyPage> createState() => _FlashcardStudyPageState();
}

class _FlashcardStudyPageState extends State<FlashcardStudyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  int _currentIndex = 0;
  bool _showAnswer = false;
  List<fc.Card> _cards = [];

  @override
  void initState() {
    super.initState();
    _cards = List.from(widget.cards);

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showAnswer) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _rateCard(int quality) {
    // TODO: Call review card use case
    _nextCard();
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
      _flipController.reset();
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Session Complete! 🎉'),
        content: Text('You reviewed ${_cards.length} cards.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _currentIndex = 0;
                _showAnswer = false;
              });
              _flipController.reset();
            },
            child: const Text('Study Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.deckTitle)),
        body: const Center(child: Text('No cards to review')),
      );
    }

    final currentCard = _cards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckTitle),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_currentIndex + 1}/${_cards.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _cards.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            // Flashcard
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    final angle = _flipAnimation.value * math.pi;
                    final showFront = angle < math.pi / 2;

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(angle),
                      child: showFront
                          ? _CardFace(text: currentCard.front, isQuestion: true)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _CardFace(
                                text: currentCard.back,
                                example: currentCard.example,
                                isQuestion: false,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Hint text
            Text(
              _showAnswer
                  ? 'How well did you remember?'
                  : 'Tap card to reveal answer',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Rating buttons (shown when answer is visible)
            if (_showAnswer) _RatingButtons(onRate: _rateCard),
          ],
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final String text;
  final String? example;
  final bool isQuestion;

  const _CardFace({required this.text, this.example, required this.isQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isQuestion ? AppColors.primary : AppColors.success,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isQuestion ? AppColors.primary : AppColors.success)
                .withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isQuestion ? Icons.help_outline : Icons.lightbulb_outline,
            color: Colors.white.withValues(alpha: 0.5),
            size: 32,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (example != null && !isQuestion) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                example!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RatingButtons extends StatelessWidget {
  final void Function(int quality) onRate;

  const _RatingButtons({required this.onRate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RatingButton(
            label: 'Again',
            color: AppColors.error,
            quality: 0,
            onTap: () => onRate(0),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _RatingButton(
            label: 'Hard',
            color: AppColors.warning,
            quality: 2,
            onTap: () => onRate(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _RatingButton(
            label: 'Good',
            color: AppColors.info,
            quality: 3,
            onTap: () => onRate(3),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _RatingButton(
            label: 'Easy',
            color: AppColors.success,
            quality: 5,
            onTap: () => onRate(5),
          ),
        ),
      ],
    );
  }
}

class _RatingButton extends StatelessWidget {
  final String label;
  final Color color;
  final int quality;
  final VoidCallback onTap;

  const _RatingButton({
    required this.label,
    required this.color,
    required this.quality,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

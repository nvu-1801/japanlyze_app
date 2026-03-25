import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Splash page shown during app initialization
class SplashPage extends StatefulWidget {
  final VoidCallback onFinished;
  
  const SplashPage({super.key, required this.onFinished});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _splashItems = [
    {
      'title': 'JapaLyze',
      'subtitle': 'Learn Japanese with AI',
      'icon': Icons.language,
    },
    {
      'title': 'Smart Flashcards',
      'subtitle': 'Study efficiently with spaced repetition.',
      'icon': Icons.style,
    },
    {
      'title': 'AI Roleplay',
      'subtitle': 'Practice conversations with AI characters.',
      'icon': Icons.chat_bubble_outline,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startSplashSequence();
  }

  void _startSplashSequence() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentIndex < _splashItems.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        timer.cancel();
        widget.onFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _buildSplashContent(_splashItems[_currentIndex]),
        ),
      ),
    );
  }

  Widget _buildSplashContent(Map<String, dynamic> item) {
    return Column(
      key: ValueKey<String>(item['title']), // Important for AnimatedSwitcher
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            item['icon'],
            size: 60,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          item['title'],
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          item['subtitle'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

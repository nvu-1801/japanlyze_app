import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // State variables for selections
  int? _selectedGoalIndex;
  int? _selectedLevelIndex;

  // Data for screens
  final List<Map<String, String>> _goals = [
    {'icon': '🗣', 'title': 'Giao tiếp hàng ngày', 'desc': 'Trò chuyện tự nhiên với người bản xứ'},
    {'icon': '📝', 'title': 'Thi JLPT (N5 → N1)', 'desc': 'Lấy bằng cấp quốc tế'},
    {'icon': '✈️', 'title': 'Du học / Làm việc', 'desc': 'Chuẩn bị cho cuộc sống tại Nhật'},
    {'icon': '🎌', 'title': 'Anime / Sở thích', 'desc': 'Hiểu văn hoá không cần phụ đề'},
  ];

  final List<Map<String, String>> _levels = [
    {'icon': '🌱', 'title': 'Chưa từng học', 'desc': 'Bắt đầu từ số 0'},
    {'icon': 'あ', 'title': 'Biết Hiragana', 'desc': 'Đã thuộc bảng chữ mềm'},
    {'icon': 'ア', 'title': 'Biết Katakana', 'desc': 'Đã thuộc bảng chữ cứng'},
    {'icon': '漢', 'title': 'Biết một ít Kanji', 'desc': 'Nhận diện được chữ Hán cơ bản'},
    {'icon': '🎓', 'title': 'Đã học N5 / N4+', 'desc': 'Có nền tảng ngữ pháp'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage++);
    } else {
      _completeOnboarding();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage--);
    }
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_onboarding', true);
    
    // Store user selections for personalization
    if (_selectedGoalIndex != null) {
      await prefs.setString('user_goal', _goals[_selectedGoalIndex!]['title']!);
    }
    if (_selectedLevelIndex != null) {
      await prefs.setString('user_level', _levels[_selectedLevelIndex!]['title']!);
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  bool _canProceed() {
    if (_currentPage == 0) return true;
    if (_currentPage == 1) return _selectedGoalIndex != null;
    if (_currentPage == 2) return _selectedLevelIndex != null;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background ambient elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.15),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: const SizedBox(),
              ),
            ),
          ),
          
          SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Prevent manual swipe constraint
              children: [
                _buildWelcomeScreen(),
                _buildGoalScreen(),
                _buildAssessmentScreen(),
              ],
            ),
          ),

          // Glassmorphism Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  decoration: BoxDecoration(
                    color: AppColors.background.withOpacity(0.8),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Next/Start Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _canProceed() ? _nextPage : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: _canProceed() ? 4 : 0,
                          ),
                          child: Text(
                            _currentPage == 0 ? 'Bắt đầu →' : 'Tiếp tục →',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Ghost Link / Step Indicator
                      if (_currentPage == 0)
                        TextButton(
                          onPressed: _goToLogin,
                          child: Text(
                            'Tôi đã có tài khoản',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: _prevPage,
                              child: Text(
                                'Quay lại',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              'Bước ${_currentPage} / 2',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 80), // Balance the row
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-20, 0),
            child: Stack(
              children: [
                // Glowing background for the character
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 60,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '日',
                  style: TextStyle(
                    fontSize: 140,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            'Hành trình tiếng Nhật của bạn bắt đầu từ đây',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tạo lộ trình cá nhân hóa chỉ trong 3 phút',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 180), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildGoalScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 64),
          const Text(
            'Bạn học tiếng Nhật để làm gì?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.separated(
              itemCount: _goals.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final isSelected = _selectedGoalIndex == index;
                return _buildSelectionCard(
                  icon: _goals[index]['icon']!,
                  title: _goals[index]['title']!,
                  desc: _goals[index]['desc']!,
                  isSelected: isSelected,
                  onTap: () => setState(() => _selectedGoalIndex = index),
                );
              },
            ),
          ),
          const SizedBox(height: 180), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildAssessmentScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 64),
          const Text(
            'Bạn đã học tiếng Nhật chưa?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: _levels.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final isSelected = _selectedLevelIndex == index;
                final isKanji = _levels[index]['icon'] == '漢';

                return _buildSelectionCard(
                  icon: _levels[index]['icon']!,
                  title: _levels[index]['title']!,
                  desc: _levels[index]['desc']!,
                  isSelected: isSelected,
                  isKanji: isKanji,
                  onTap: () => setState(() => _selectedLevelIndex = index),
                );
              },
            ),
          ),
          const SizedBox(height: 180), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String icon,
    required String title,
    required String desc,
    required bool isSelected,
    bool isKanji = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.secondary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            if (isKanji)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    icon,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ],
              )
            else
              Text(
                icon,
                style: const TextStyle(fontSize: 32),
              ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}

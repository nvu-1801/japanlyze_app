import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/dashboard/dashboard_bloc.dart';
import 'home/tabs/dashboard_tab.dart';
import 'home/tabs/roadmap_tab.dart';
import 'home/tabs/exercises/exercises_tab.dart';
import 'home/tabs/exam_tab.dart';
import 'home/reading_page.dart';
import 'home/widgets/home_bottom_nav.dart';

final sl = GetIt.instance;

/// Main home page with modern bottom navigation
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    DashboardTab(
      onNavigateToTab: (index) => setState(() => _currentIndex = index),
    ),
    const ReadingPage(),
    const RoadmapTab(),
    const ExercisesTab(),
    const ExamTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildCurrentPage(),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.02, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      ),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _buildCurrentPage() {
    // Provide DashboardBloc only for DashboardTab
    if (_currentIndex == 0) {
      return BlocProvider(
        create: (context) => sl<DashboardBloc>(),
        child: DashboardTab(
          onNavigateToTab: (index) => setState(() => _currentIndex = index),
          onNavigateToRoadmap: () => setState(() => _currentIndex = 2),
          onNavigateToReading: () => setState(() => _currentIndex = 1),
          onNavigateToExams: () => setState(() => _currentIndex = 4),
        ),
      );
    }
    return _pages[_currentIndex];
  }
}

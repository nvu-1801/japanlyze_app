import 'package:shared_preferences/shared_preferences.dart';

class DailyGoalService {
  static const String _key = 'daily_goal_minutes';
  static const int defaultGoal = 20;

  static final DailyGoalService _instance = DailyGoalService._internal();
  factory DailyGoalService() => _instance;
  DailyGoalService._internal();

  Future<int> getDailyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? defaultGoal;
  }

  Future<void> setDailyGoal(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, minutes);
  }
}

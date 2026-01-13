/// App constants for JapaLyze
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'JapaLyze';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'cached_user';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String onboardingKey = 'onboarding_complete';

  // API
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Pagination
  static const int defaultPageSize = 20;

  // SRS Constants
  static const double defaultEaseFactor = 2.5;
  static const int minInterval = 1;
  static const int maxInterval = 365;

  // Gamification
  static const int xpPerFlashcardReview = 5;
  static const int xpPerExerciseComplete = 20;
  static const int xpPerRoleplay = 15;
  static const int xpPerLevelUp = 100;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'core/theme/app_theme.dart';
import 'data/services/isar_service.dart';
import 'data/services/local_notification_service.dart';
import 'injection_container.dart' as di;
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/blocs/notification/notification_bloc.dart';
import 'presentation/blocs/notification/notification_event.dart';
import 'presentation/blocs/notification/notification_state.dart';
import 'core/constants/app_colors.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize dependencies
  await di.init();

  // Initialize Isar database for offline-first architecture
  await IsarService.instance.initialize();

  // Initialize Local Notifications
  await LocalNotificationService.instance.initialize();

  runApp(const JapaLyzeApp());
}

class JapaLyzeApp extends StatelessWidget {
  const JapaLyzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(GetCurrentUserEvent()),
        ),
        BlocProvider(create: (_) => ThemeBloc()..add(LoadThemeEvent())),
        BlocProvider(
          create: (_) =>
              di.sl<NotificationBloc>()..add(NotificationLoadRequested()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => MaterialApp(
          title: 'JapaLyze',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          home: const AuthWrapper(),
          routes: {
            '/login': (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
            '/home': (_) => const HomePage(),
            '/onboarding': (_) => const OnboardingPage(),
            '/settings': (_) => const SettingsPage(),
          },
        ),
      ),
    );
  }
}

/// Wrapper widget to handle authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationCreated) {
              // Trigger vibration
              HapticFeedback.heavyImpact();

              // Show in-app banner
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        state.notification.type == 'exam'
                            ? Icons.assignment_rounded
                            : Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.notification.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              state.notification.message,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    80,
                  ), // Position above bottom nav
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'XEM',
                    textColor: Colors.white,
                    onPressed: () {
                      // Handled by the notification icon usually, but nice to have
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print('AuthWrapper: Current state: $state');
          if (state is AuthInitial || state is AuthLoading) {
            return const SplashPage();
          } else if (state is AuthAuthenticated) {
            print('AuthWrapper: User authenticated: ${state.user.uuid}');
            return const HomePage();
          } else {
            print('AuthWrapper: User not authenticated');
            return const LoginPage();
          }
        },
      ),
    );
  }
}

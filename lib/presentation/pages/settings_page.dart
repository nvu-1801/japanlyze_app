import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../../domain/entities/user.dart';
import '../../data/services/daily_goal_service.dart';

/// Settings page — only shows items that actually work
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _dailyGoalMinutes = DailyGoalService.defaultGoal;

  @override
  void initState() {
    super.initState();
    _loadDailyGoal();
  }

  Future<void> _loadDailyGoal() async {
    final goal = await DailyGoalService().getDailyGoal();
    if (mounted) setState(() => _dailyGoalMinutes = goal);
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final user = authState is AuthAuthenticated
        ? authState.user
        : User(
            id: 1,
            name: 'Mock User',
            email: 'mock@example.com',
            role: 'user',
            isPremium: false,
            createdAt: DateTime.now(),
            streakCount: 0,
            exp: 0,
            level: 1,
            uuid: '',
          );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Cài đặt',
            style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // ─── Profile Header ───────────────────────────────────────────
            _ProfileHeader(user: user),
            const SizedBox(height: 8),
            // ─── Appearance ──────────────────────────────────────────────
            _SectionHeader(title: 'Giao diện'),
            _SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Chế độ tối',
              trailing: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) => Switch.adaptive(
                  value: state.themeMode == ThemeMode.dark,
                  activeColor: AppColors.primary,
                  onChanged: (val) =>
                      context.read<ThemeBloc>().add(ToggleThemeEvent(val)),
                ),
              ),
              onTap: () {
                final current = context.read<ThemeBloc>().state.themeMode;
                context.read<ThemeBloc>().add(
                  ToggleThemeEvent(current != ThemeMode.dark),
                );
              },
            ),

            const SizedBox(height: 16),

            // ─── Learning ────────────────────────────────────────────────────
            _SectionHeader(title: 'Học tập'),
            _SettingsTile(
              icon: Icons.schedule_rounded,
              title: 'Mục tiêu hàng ngày',
              trailing: Text(
                '$_dailyGoalMinutes phút',
                style: GoogleFonts.lexend(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _showDailyGoalPicker(context),
            ),

            const SizedBox(height: 16),

            // ─── About ───────────────────────────────────────────────────────
            _SectionHeader(title: 'Thông tin'),
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              title: 'Về JapaLyze',
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'JapaLyze',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(size: 48),
                children: [
                  const Text('Học tiếng Nhật thông minh hơn mỗi ngày!'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── Danger Zone ─────────────────────────────────────────────────
            _SectionHeader(title: 'Tài khoản'),
            _SettingsTile(
              icon: Icons.logout_rounded,
              iconColor: AppColors.error,
              title: 'Đăng xuất',
              titleColor: AppColors.error,
              showChevron: false,
              onTap: () => _showLogoutDialog(context),
            ),

            const SizedBox(height: 32),
            Center(
              child: Text(
                'Phiên bản 1.0.0',
                style: GoogleFonts.lexend(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Daily Goal picker dialog
  void _showDailyGoalPicker(BuildContext context) {
    final options = [5, 10, 15, 20, 30, 45, 60];
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Mục tiêu hàng ngày',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: options.map((min) {
                final selected = min == _dailyGoalMinutes;
                return GestureDetector(
                  onTap: () async {
                    await DailyGoalService().setDailyGoal(min);
                    if (mounted) setState(() => _dailyGoalMinutes = min);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      '$min phút',
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Đăng xuất',
          style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Bạn có chắc muốn đăng xuất không?',
          style: GoogleFonts.lexend(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Hủy', style: GoogleFonts.lexend()),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(LogoutEvent());
            },
            child: Text('Đăng xuất', style: GoogleFonts.lexend()),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────  Sub-widgets  ────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final User user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2.5),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Name + email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.lexend(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.grey[500],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.isPremium) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⭐ Premium',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatChip(
                icon: '🔥',
                value: '${user.streakCount}',
                label: 'Streak',
              ),
              _StatChip(icon: '⚡', value: '${user.exp}', label: 'XP'),
              _StatChip(icon: '🏆', value: 'Lv.${user.level}', label: 'Level'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 11,
            color: isDark ? Colors.white38 : Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.lexend(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final Color? titleColor;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    this.iconColor,
    required this.title,
    this.titleColor,
    this.trailing,
    this.showChevron = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: titleColor,
                ),
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null && showChevron)
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

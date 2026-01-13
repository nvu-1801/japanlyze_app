import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../blocs/auth/auth_bloc.dart';

/// Settings page with user preferences
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          // Account Section
          _SectionHeader(title: 'Account'),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.language,
            title: 'Language',
            trailing: const Text('English'),
            onTap: () {},
          ),
          const Divider(),
          // Learning Section
          _SectionHeader(title: 'Learning'),
          _SettingsTile(
            icon: Icons.schedule,
            title: 'Daily Goal',
            trailing: const Text('20 min'),
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            trailing: Switch(value: true, onChanged: (value) {}),
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.download_outlined,
            title: 'Offline Content',
            onTap: () {},
          ),
          const Divider(),
          // Appearance Section
          _SectionHeader(title: 'Appearance'),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // TODO: Toggle theme
              },
            ),
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.text_fields,
            title: 'Font Size',
            trailing: const Text('Medium'),
            onTap: () {},
          ),
          const Divider(),
          // About Section
          _SectionHeader(title: 'About'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About JapaLyze',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'JapaLyze',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(size: 48),
                children: [const Text('Learn Japanese the smart way!')],
              );
            },
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          const Divider(),
          // Danger Zone
          _SettingsTile(
            icon: Icons.logout,
            iconColor: AppColors.error,
            title: 'Logout',
            titleColor: AppColors.error,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          _SettingsTile(
            icon: Icons.delete_forever,
            iconColor: AppColors.error,
            title: 'Delete Account',
            titleColor: AppColors.error,
            onTap: () {
              _showDeleteAccountDialog(context);
            },
          ),
          const SizedBox(height: 24),
          // App Version
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Temporarily commented out for UI development
              // context.read<AuthBloc>().add(LogoutEvent());
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Delete account
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
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
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    this.iconColor,
    required this.title,
    this.titleColor,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: titleColor)),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    _nameController = TextEditingController(text: profile?.name ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    _phoneController = TextEditingController(text: profile?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);

    if (profile != null &&
        (_nameController.text != profile.name ||
            _emailController.text != profile.email ||
            _phoneController.text != profile.phone)) {
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _SettingsSection(
              title: 'Profile',
              items: [
                _ProfileFormTile(
                  title: 'Name',
                  controller: _nameController,
                  hintText: 'Enter your full name',
                  icon: Icons.person_outline,
                ),
                _ProfileFormTile(
                  title: 'Email',
                  controller: _emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                _ProfileFormTile(
                  title: 'Phone',
                  controller: _phoneController,
                  hintText: 'Enter your phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _SettingsSection(
              title: 'Account',
              items: [
                _SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Addresses',
                  subtitle: 'Manage your saved delivery locations',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.credit_card_outlined,
                  title: 'Payment methods',
                  subtitle: 'Card and mobile money preferences',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _SettingsSection(
              title: 'Preferences',
              items: [
                _SettingsTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  subtitle: 'Promotions, order updates and reminders',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Appearance',
                  subtitle: 'Light mode is currently enabled',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English (US)',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _SettingsSection(
              title: 'Support',
              items: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help center',
                  subtitle: 'Find answers to common questions',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy policy',
                  subtitle: 'Read how your data is used',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.logout,
                  title: 'Log out',
                  subtitle: 'Sign out of your account',
                  onTap: () {},
                  isDestructive: true,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(userProfileProvider.notifier).updateProfile(
                    name: _nameController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29)
                  )
                ),
                child: const Text('Save changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _ProfileFormTile extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;

  const _ProfileFormTile({
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: AppColors.greyLight,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? AppColors.error : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDestructive ? AppColors.error : AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_radius.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';

/// Profile tab showing user information
class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  Future<void> _pickAvatar(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (pickedFile == null) return;

    ref.read(userProfileProvider.notifier).updateProfileImage(pickedFile.path);
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickAvatar(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: userProfile == null
          ? const Center(child: Text('No user profile'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showAvatarPicker,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  image: userProfile.profileImage != null
                                      ? DecorationImage(
                                          image: userProfile.profileImage!.startsWith('http')
                                              ? NetworkImage(userProfile.profileImage!)
                                              : FileImage(File(userProfile.profileImage!)),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: userProfile.profileImage == null
                                    ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Theme.of(context).colorScheme.primary,
                                      )
                                    : null,
                              ),
                              Positioned(
                                right: -6,
                                bottom: -6,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          userProfile.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          userProfile.email,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.white.withValues(alpha: 0.9),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          userProfile.phone,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.white.withValues(alpha: 0.9),
                              ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        _ProfileMenuItem(
                          icon: Icons.shopping_bag_outlined,
                          title: 'My Orders',
                          subtitle: 'View order history',
                          onTap: () => context.push('/orders'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProfileMenuItem(
                          icon: Icons.favorite_outline,
                          title: 'Saved Foods',
                          subtitle: 'Your favorite items',
                          onTap: () {},
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProfileMenuItem(
                          icon: Icons.location_on_outlined,
                          title: 'Saved Addresses',
                          subtitle: '${userProfile.savedAddresses.length} addresses',
                          onTap: () {},
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProfileMenuItem(
                          icon: Icons.credit_card_outlined,
                          title: 'Payment Methods',
                          subtitle: '${userProfile.savedPaymentMethods.length} methods',
                          onTap: () {},
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProfileMenuItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          subtitle: 'App preferences',
                          onTap: () => context.push('/settings'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProfileMenuItem(
                          icon: Icons.logout_outlined,
                          title: 'Log Out',
                          subtitle: 'Sign out of your account',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Log Out?'),
                                content: const Text(
                                    'Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      context.go('/login');
                                    },
                                    child: const Text('Log Out'),
                                  ),
                                ],
                              ),
                            );
                          },
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      'FoodHouse v1.0.0',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

/// Reusable profile menu item
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive
                  ? AppColors.error
                  : Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isDestructive ? AppColors.error : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

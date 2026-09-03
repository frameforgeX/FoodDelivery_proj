import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/features/home/screens/home_tab.dart';
import 'package:food_odering_app/features/menu/screens/menu_tab.dart';
import 'package:food_odering_app/features/favorites/screens/favorites_tab.dart';
import 'package:food_odering_app/features/profile/screens/profile_tab.dart';
import 'package:food_odering_app/features/cart/providers/cart_provider.dart';

/// Main screen with Google-style bottom navigation
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const MenuTab(),
    const FavoritesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: GNav(
              backgroundColor: AppColors.white,
              color: AppColors.textSecondary,
              activeColor: AppColors.primary,
              tabBackgroundColor: AppColors.primary.withValues(alpha: 0.08),
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: [
                GButton(
                  icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  text: 'Home',
                  iconColor: AppColors.textSecondary,
                  iconActiveColor: AppColors.primary,
                  textColor: AppColors.primary,
                ),
                GButton(
                  icon: _selectedIndex == 1 ? Icons.menu_book : Icons.menu_book_outlined,
                  text: 'Menu',
                  iconColor: AppColors.textSecondary,
                  iconActiveColor: AppColors.primary,
                  textColor: AppColors.primary,
                ),
                GButton(
                  icon: _selectedIndex == 2 ? Icons.favorite : Icons.favorite_border,
                  text: 'Saved',
                  iconColor: AppColors.textSecondary,
                  iconActiveColor: AppColors.primary,
                  textColor: AppColors.primary,
                ),
                GButton(
                  icon: _selectedIndex == 3 ? Icons.person : Icons.person_outline,
                  text: 'Profile',
                  iconColor: AppColors.textSecondary,
                  iconActiveColor: AppColors.primary,
                  textColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: cartCount > 0
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/cart'),
              label: Text('$cartCount items'),
              icon: const Icon(Icons.shopping_bag),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: AppColors.white,
            )
          : null,
    );
  }
}

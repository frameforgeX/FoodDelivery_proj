import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/widgets/food_card.dart';
import 'package:food_odering_app/features/menu/providers/food_provider.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';

/// Favorites tab showing saved foods
class FavoritesTab extends ConsumerWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final allFoodsAsync = ref.watch(allFoodsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Foods'),
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 80,
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'No saved foods yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Add your favorite foods here for quick access',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : allFoodsAsync.when(
              data: (allFoods) {
                // Filter foods by favorites
                final favoriteFoods =
                    allFoods.where((food) => favorites.contains(food.id)).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemCount: favoriteFoods.length,
                  itemBuilder: (context, index) {
                    return FoodCard(food: favoriteFoods[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Center(
                child: Text('Error: $err'),
              ),
            ),
    );
  }
}

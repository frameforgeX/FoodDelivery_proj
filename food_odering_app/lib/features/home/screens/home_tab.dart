import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/widgets/custom_search_bar.dart';
import 'package:food_odering_app/core/widgets/category_card.dart';
import 'package:food_odering_app/core/widgets/food_card.dart';
import 'package:food_odering_app/features/menu/providers/category_provider.dart';
import 'package:food_odering_app/features/menu/providers/food_provider.dart';

/// Home tab showing featured and popular foods
class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(foodCategoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final featuredFoodsAsync = ref.watch(featuredFoodsProvider);
    final popularFoodsAsync = ref.watch(popularFoodsProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant Logo & Name
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.restaurant,
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FoodHouse',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Delicious Food Delivered Fast',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Greeting
                    Text(
                      'Good Morning! 👋',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'What would you like to eat today?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    CustomSearchBar(
                      onTap: () => context.push('/search'),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Categories Section
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Categories Carousel
                    categoriesAsync.when(
                      data: (categories) => SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: AppSpacing.md),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = selectedCategory == category.id;

                            return CategoryCard(
                              category: category,
                              isSelected: isSelected,
                              onTap: () {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .selectCategory(category.id);
                              },
                            );
                          },
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (err, stack) => Center(
                        child: Text('Error: $err'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Featured Foods Section
                    Text(
                      'Featured Today ⭐',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    featuredFoodsAsync.when(
                      data: (foods) => foods.isEmpty
                          ? Center(
                              child: Text(
                                'No featured foods available',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                              ),
                              itemCount: foods.length,
                              itemBuilder: (context, index) {
                                return FoodCard(food: foods[index]);
                              },
                            ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (err, stack) => Center(
                        child: Text('Error: $err'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Popular Foods Section
                    Text(
                      'Popular & Trending 🔥',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    popularFoodsAsync.when(
                      data: (foods) => foods.isEmpty
                          ? Center(
                              child: Text(
                                'No popular foods available',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                              ),
                              itemCount: foods.length,
                              itemBuilder: (context, index) {
                                return FoodCard(food: foods[index]);
                              },
                            ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (err, stack) => Center(
                        child: Text('Error: $err'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

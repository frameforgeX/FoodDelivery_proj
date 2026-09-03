import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/widgets/food_card.dart';
import 'package:food_odering_app/features/menu/providers/category_provider.dart';
import 'package:food_odering_app/features/menu/providers/food_provider.dart';

/// Menu tab for browsing foods by category
class MenuTab extends ConsumerStatefulWidget {
  const MenuTab({super.key});

  @override
  ConsumerState<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends ConsumerState<MenuTab> {
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(foodCategoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        elevation: 0,
      ),
      body: categoriesAsync.when(
        data: (categories) {
          // Get selected category or first one
          final activeCategoryId = selectedCategory ?? (categories.isNotEmpty ? categories.first.id : null);

          return Column(
            children: [
              // Category Tabs
              Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isActive = activeCategoryId == category.id;

                      return FilterChip(
                        label: Text('${category.icon} ${category.name}'),
                        selected: isActive,
                        onSelected: (selected) {
                          if (selected) {
                            ref
                                .read(selectedCategoryProvider.notifier)
                                .selectCategory(category.id);
                          }
                        },
                        backgroundColor: AppColors.greyLight,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isActive ? AppColors.white : AppColors.textPrimary,
                            ),
                      );
                    },
                  ),
                ),
              ),

              // Foods Grid
              Expanded(
                child: activeCategoryId != null
                    ? ref.watch(foodsByCategoryProvider(activeCategoryId)).when(
                          data: (foods) => foods.isEmpty
                              ? Center(
                                  child: Text(
                                    'No foods in this category',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              : GridView.builder(
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.50,
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
                        )
                    : Center(
                        child: Text(
                          'Select a category',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
              ),
            ],
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

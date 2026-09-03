import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/constants/app_radius.dart';
import 'package:food_odering_app/core/widgets/custom_search_bar.dart';
import 'package:food_odering_app/core/widgets/food_card.dart';
import 'package:food_odering_app/features/menu/providers/category_provider.dart';
import 'package:food_odering_app/features/menu/providers/food_provider.dart';
import 'package:food_odering_app/models/food.dart';

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
        child: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.secondary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deliver to', style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          'New York, NY',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Open cart',
                    onPressed: () => context.push('/cart'),
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: CustomSearchBar(onTap: () => context.push('/search')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                height: 156,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/jollof.jpeg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                    opacity: 0.28,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Free delivery today', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Fresh meals, right to your door.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white)),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () => context.push('/menu'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary, foregroundColor: AppColors.white),
                        child: const Text('Order now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text('What are you craving?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 48,
              child: categoriesAsync.when(
                data: (categories) => ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category.id;
                    return ChoiceChip(
                      selected: isSelected,
                      label: Text('${category.icon}  ${category.name}'),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.textPrimary),
                      onSelected: (_) => ref.read(selectedCategoryProvider.notifier).selectCategory(category.id),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _FoodCarousel(title: 'New on FoodHouse', foodsAsync: featuredFoodsAsync),
            const SizedBox(height: AppSpacing.xl),
            _FoodCarousel(title: 'Popular near you', foodsAsync: popularFoodsAsync),
          ],
        ),
      ),
    );
  }
}

class _FoodCarousel extends StatelessWidget {
  final String title;
  final AsyncValue<List<Food>> foodsAsync;

  const _FoodCarousel({required this.title, required this.foodsAsync});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
              TextButton(onPressed: () => context.push('/menu'), child: const Text('See all')),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 300,
          child: foodsAsync.when(
            data: (foods) => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) => SizedBox(width: 220, child: FoodCard(food: foods[index])),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }
}

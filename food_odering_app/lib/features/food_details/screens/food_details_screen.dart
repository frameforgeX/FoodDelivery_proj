import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/features/cart/providers/cart_provider.dart';
import 'package:food_odering_app/features/menu/providers/food_provider.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';
import 'package:food_odering_app/models/cart_item.dart';

class FoodDetailsScreen extends ConsumerStatefulWidget {
  final String foodId;

  const FoodDetailsScreen({super.key, required this.foodId});

  @override
  ConsumerState<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends ConsumerState<FoodDetailsScreen> {
  String? selectedSize;
  final List<String> selectedAddOns = [];
  int quantity = 1;
  final TextEditingController instructionsController = TextEditingController();

  @override
  void dispose() {
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodsAsync = ref.watch(allFoodsProvider);
    final favorites = ref.watch(favoritesProvider);

    return foodsAsync.when(
      data: (foods) {
        final food = foods.firstWhere(
          (item) => item.id == widget.foodId,
          orElse: () => foods.first,
        );

        selectedSize ??= food.sizes.isNotEmpty ? food.sizes.first : null;

        final isFavorite = favorites.contains(food.id);

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  actions: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        ref.read(favoritesProvider.notifier).toggleFavorite(food.id);
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      food.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                food.name,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Text(
                              '\$${food.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: AppSpacing.xs),
                            Text('${food.rating} (${food.reviewCount} reviews)'),
                            const SizedBox(width: AppSpacing.md),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                food.isAvailable ? 'Available now' : 'Unavailable',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          food.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _SectionTitle(title: 'Size'),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: food.sizes.map((size) {
                            final isSelected = selectedSize == size;
                            return ChoiceChip(
                              label: Text(size),
                              selected: isSelected,
                              onSelected: (_) => setState(() => selectedSize = size),
                            );
                          }).toList(),
                        ),
                        if (food.addOns.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xl),
                          _SectionTitle(title: 'Add-ons'),
                          const SizedBox(height: AppSpacing.md),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: food.addOns.map((addon) {
                              final isSelected = selectedAddOns.contains(addon);
                              return FilterChip(
                                label: Text(addon),
                                selected: isSelected,
                                onSelected: (_) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedAddOns.remove(addon);
                                    } else {
                                      selectedAddOns.add(addon);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        _SectionTitle(title: 'Ingredients'),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: food.ingredients
                              .map(
                                (ingredient) => Chip(
                                  label: Text(ingredient),
                                  backgroundColor: AppColors.greyLight,
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _SectionTitle(title: 'Special instructions'),
                        const SizedBox(height: AppSpacing.md),
                        TextField(
                          controller: instructionsController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Extra sauce, no onions, well done...',
                            filled: true,
                            fillColor: AppColors.greyLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionTitle(title: 'Quantity'),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.greyLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => setState(() {
                                      if (quantity > 1) quantity--;
                                    }),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      quantity.toString(),
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => setState(() => quantity++),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
            child: FilledButton.icon(
              onPressed: () {
                final cartItem = CartItem(
                  foodId: food.id,
                  foodName: food.name,
                  price: food.price,
                  image: food.image,
                  quantity: quantity,
                  selectedSize: selectedSize,
                  selectedAddOns: selectedAddOns,
                  specialInstructions: instructionsController.text.trim().isEmpty
                      ? null
                      : instructionsController.text.trim(),
                );

                ref.read(cartProvider.notifier).addToCart(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${food.name} added to cart'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text('Add to cart • \$${(food.price * quantity).toStringAsFixed(2)}'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

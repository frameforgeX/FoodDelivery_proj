import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/models/food.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/constants/app_radius.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';
import 'package:food_odering_app/features/cart/providers/cart_provider.dart';
import 'package:food_odering_app/models/cart_item.dart';

/// Reusable food card widget
class FoodCard extends ConsumerWidget {
  final Food food;
  final VoidCallback? onAddToCart;

  const FoodCard({
    super.key,
    required this.food,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(food.id);
    final cartNotifier = ref.read(cartProvider.notifier);
    final favorites = ref.read(favoritesProvider.notifier);

    return GestureDetector(
      onTap: () => context.push('/food-details/${food.id}'),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.lg),
                      topRight: Radius.circular(AppRadius.lg),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(food.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Favorite Button
                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: GestureDetector(
                    onTap: () {
                      favorites.toggleFavorite(food.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColors.error : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                // Special Offer Badge
                if (food.specialOffer != null)
                  Positioned(
                    top: AppSpacing.md,
                    left: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Text(
                        food.specialOffer!,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Description
                  Text(
                    food.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Price & Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${food.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${food.rating}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final cartItem = CartItem(
                          foodId: food.id,
                          foodName: food.name,
                          price: food.price,
                          image: food.image,
                          quantity: 1,
                        );
                        cartNotifier.addToCart(cartItem);

                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${food.name} added to cart'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        if (onAddToCart != null) {
                          onAddToCart!();
                        }
                      },
                      icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                      label: const Text('Add'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

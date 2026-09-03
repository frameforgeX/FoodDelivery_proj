import 'package:flutter/material.dart';
import 'package:food_odering_app/models/food_category.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';

/// Reusable category card widget for carousel
class CategoryCard extends StatelessWidget {
  final FoodCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Circle with emoji/icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : AppColors.greyLight,
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                category.icon,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Category name
          Text(
            category.name,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/core/constants/app_radius.dart';

/// Reusable search bar widget (non-conflicting name)
class CustomSearchBar extends ConsumerWidget {
  final VoidCallback? onTap;

  const CustomSearchBar({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.push('/search');
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              'Search foods...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

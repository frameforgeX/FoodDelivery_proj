import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/models/food_category.dart';
import 'package:food_odering_app/data/mock/mock_categories.dart';

/// Provider for all food categories
final foodCategoriesProvider = FutureProvider<List<FoodCategory>>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 300));
  return mockFoodCategories;
});

/// Notifier for selected category
class SelectedCategoryNotifier extends StateNotifier<String?> {
  SelectedCategoryNotifier() : super(null);

  void selectCategory(String categoryId) {
    state = categoryId;
  }

  void clearSelection() {
    state = null;
  }
}

/// Provider for selected category
final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryNotifier, String?>((ref) {
  return SelectedCategoryNotifier();
});

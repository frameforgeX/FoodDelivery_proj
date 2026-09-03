import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/models/food.dart';
import 'package:food_odering_app/data/mock/mock_foods.dart';

/// Provider for all foods
final allFoodsProvider = FutureProvider<List<Food>>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 500));
  return mockFoods;
});

/// Provider for featured foods
final featuredFoodsProvider = FutureProvider<List<Food>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return getFeaturedFoods();
});

/// Provider for popular foods
final popularFoodsProvider = FutureProvider<List<Food>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return getPopularFoods();
});

/// Provider for foods by category
final foodsByCategoryProvider =
    FutureProvider.family<List<Food>, String>((ref, categoryId) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return getFoodsByCategory(categoryId);
});

/// Provider for food search
final foodSearchProvider = FutureProvider.family<List<Food>, String>((ref, query) async {
  if (query.isEmpty) {
    return [];
  }
  await Future.delayed(const Duration(milliseconds: 200));
  return searchFoods(query);
});

/// Notifier for search query
class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super('');

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

/// Provider for search query state
final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>((ref) {
  return SearchQueryNotifier();
});

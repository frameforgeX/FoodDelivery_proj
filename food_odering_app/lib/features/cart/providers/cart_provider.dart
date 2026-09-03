import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/models/cart_item.dart';

/// Notifier for managing cart state
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  /// Add item to cart
  void addToCart(CartItem item) {
    // Check if item with same food and customizations already exists
    final existingIndex = state.indexWhere((cartItem) =>
        cartItem.foodId == item.foodId &&
        cartItem.selectedSize == item.selectedSize &&
        _listEquals(cartItem.selectedAddOns, item.selectedAddOns));

    if (existingIndex != -1) {
      // Update quantity if item exists
      final updatedItem =
          state[existingIndex].copyWith(quantity: state[existingIndex].quantity + item.quantity);
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Add new item
      state = [...state, item];
    }
  }

  /// Remove item from cart
  void removeFromCart(String cartItemId) {
    state = state.where((item) => item.id != cartItemId).toList();
  }

  /// Update item quantity
  void updateQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    state = state.map((item) {
      if (item.id == cartItemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
  }

  /// Clear entire cart
  void clearCart() {
    state = [];
  }

  /// Helper to compare lists
  bool _listEquals(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}

/// Provider for cart state
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Provider for cart total
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<double>(0, (total, item) => total + item.totalPrice);
});

/// Provider for cart item count
final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<int>(0, (count, item) => count + item.quantity);
});

/// Provider for cart subtotal
final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold<double>(0, (total, item) {
    double itemPrice = item.price + (item.selectedAddOns.length * 2.0);
    return total + (itemPrice * item.quantity);
  });
});

import 'package:uuid/uuid.dart';

/// Cart item model (extends Food with order-specific properties)
class CartItem {
  final String id;
  final String foodId;
  final String foodName;
  final double price;
  final String image;
  final int quantity;
  final String? selectedSize;
  final List<String> selectedAddOns;
  final String? specialInstructions;

  CartItem({
    String? id,
    required this.foodId,
    required this.foodName,
    required this.price,
    required this.image,
    this.quantity = 1,
    this.selectedSize,
    this.selectedAddOns = const [],
    this.specialInstructions,
  }) : id = id ?? const Uuid().v4();

  /// Total price including add-ons
  double get totalPrice {
    double addOnPrice = selectedAddOns.length * 2.0; // Assuming $2 per add-on
    return (price + addOnPrice) * quantity;
  }

  CartItem copyWith({
    String? id,
    String? foodId,
    String? foodName,
    double? price,
    String? image,
    int? quantity,
    String? selectedSize,
    List<String>? selectedAddOns,
    String? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  String toString() =>
      'CartItem(id: $id, foodName: $foodName, quantity: $quantity, total: $totalPrice)';
}

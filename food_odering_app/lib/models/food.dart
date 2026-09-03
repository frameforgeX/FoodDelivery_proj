import 'package:uuid/uuid.dart';

/// Food item model
class Food {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double rating;
  final int reviewCount;
  final String category;
  final List<String> ingredients;
  final List<String> sizes; // ['Small', 'Medium', 'Large']
  final List<String> addOns; // ['Extra cheese', 'Bacon', etc.]
  final int preparationTime; // in minutes
  final bool isAvailable;
  final bool isFeatured;
  final String? specialOffer;

  Food({
    String? id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.category,
    this.ingredients = const [],
    this.sizes = const ['Small', 'Medium', 'Large'],
    this.addOns = const [],
    this.preparationTime = 30,
    this.isAvailable = true,
    this.isFeatured = false,
    this.specialOffer,
  }) : id = id ?? const Uuid().v4();

  Food copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    double? rating,
    int? reviewCount,
    String? category,
    List<String>? ingredients,
    List<String>? sizes,
    List<String>? addOns,
    int? preparationTime,
    bool? isAvailable,
    bool? isFeatured,
    String? specialOffer,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      sizes: sizes ?? this.sizes,
      addOns: addOns ?? this.addOns,
      preparationTime: preparationTime ?? this.preparationTime,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      specialOffer: specialOffer ?? this.specialOffer,
    );
  }

  @override
  String toString() => 'Food(id: $id, name: $name, price: $price)';
}

import 'package:food_odering_app/models/food.dart';

/// Mock food items data
final List<Food> mockFoods = [
  // Burgers
  Food(
    id: 'burger_1',
    name: 'Classic Cheeseburger',
    description: 'Juicy beef patty with melted cheddar, lettuce, tomato, and our special sauce',
    image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&h=500&fit=crop',
    price: 8.99,
    rating: 4.8,
    reviewCount: 256,
    category: '1',
    ingredients: ['Beef Patty', 'Cheddar Cheese', 'Lettuce', 'Tomato', 'Onion'],
    sizes: ['Small', 'Medium', 'Large'],
    addOns: ['Extra Cheese', 'Bacon', 'Avocado'],
    preparationTime: 15,
    isAvailable: true,
    isFeatured: true,
  ),
  Food(
    id: 'burger_2',
    name: 'Bacon Burger',
    description: 'Double patty with crispy bacon, Swiss cheese, and pickles',
    image: 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=500&h=500&fit=crop',
    price: 10.99,
    rating: 4.7,
    reviewCount: 189,
    category: '1',
    ingredients: ['Double Beef Patty', 'Bacon', 'Swiss Cheese', 'Pickles'],
    preparationTime: 18,
    isAvailable: true,
    isFeatured: false,
    specialOffer: '20% OFF',
  ),

  // Pizza
  Food(
    id: 'pizza_1',
    name: 'Margherita Pizza',
    description: 'Fresh mozzarella, basil, and tomato sauce on thin crust',
    image: 'https://images.unsplash.com/photo-1584814050519-46ec810a555e?w=500&h=500&fit=crop',
    price: 12.99,
    rating: 4.9,
    reviewCount: 423,
    category: '2',
    ingredients: ['Tomato Sauce', 'Mozzarella', 'Basil', 'Olive Oil'],
    sizes: ['Small (10")', 'Medium (12")', 'Large (14")'],
    addOns: ['Extra Cheese', 'Pepperoni', 'Mushrooms', 'Olives'],
    preparationTime: 20,
    isAvailable: true,
    isFeatured: true,
  ),
  Food(
    id: 'pizza_2',
    name: 'Pepperoni Pizza',
    description: 'Classic pepperoni with extra cheese and Italian herbs',
    image: 'https://images.unsplash.com/photo-1628840042765-356cda07f4ee?w=500&h=500&fit=crop',
    price: 13.99,
    rating: 4.6,
    reviewCount: 312,
    category: '2',
    ingredients: ['Tomato Sauce', 'Mozzarella', 'Pepperoni', 'Italian Herbs'],
    preparationTime: 20,
    isAvailable: true,
    isFeatured: false,
  ),

  // Chicken
  Food(
    id: 'chicken_1',
    name: 'Fried Chicken Combo',
    description: '3 pieces crispy fried chicken with fries and coleslaw',
    image: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc46e?w=500&h=500&fit=crop',
    price: 11.99,
    rating: 4.7,
    reviewCount: 267,
    category: '3',
    ingredients: ['Chicken', 'Breading', 'Spices'],
    sizes: ['3 pieces', '5 pieces', '8 pieces'],
    addOns: ['Extra Sauce', 'Honey Mustard'],
    preparationTime: 12,
    isAvailable: true,
    isFeatured: true,
  ),
  Food(
    id: 'chicken_2',
    name: 'Spicy Chicken Wings',
    description: '1 lb of hot spicy chicken wings with ranch dipping sauce',
    image: 'https://images.unsplash.com/photo-1599599810694-b5ac4dd64b73?w=500&h=500&fit=crop',
    price: 9.99,
    rating: 4.5,
    reviewCount: 178,
    category: '3',
    ingredients: ['Chicken Wings', 'Spices', 'Hot Sauce'],
    preparationTime: 15,
    isAvailable: true,
    isFeatured: false,
  ),

  // Rice Dishes
  Food(
    id: 'rice_1',
    name: 'Fried Rice',
    description: 'Aromatic jasmine rice with egg, vegetables, and your choice of protein',
    image: 'https://images.unsplash.com/photo-1585238341710-4b4e6cefc896?w=500&h=500&fit=crop',
    price: 10.49,
    rating: 4.6,
    reviewCount: 234,
    category: '4',
    ingredients: ['Rice', 'Eggs', 'Vegetables', 'Soy Sauce'],
    sizes: ['Regular', 'Large'],
    addOns: ['Extra Protein', 'Extra Vegetables'],
    preparationTime: 12,
    isAvailable: true,
    isFeatured: false,
  ),

  // Pasta
  Food(
    id: 'pasta_1',
    name: 'Spaghetti Carbonara',
    description: 'Classic Italian pasta with creamy sauce, bacon, and parmesan',
    image: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=500&h=500&fit=crop',
    price: 12.49,
    rating: 4.8,
    reviewCount: 289,
    category: '5',
    ingredients: ['Spaghetti', 'Bacon', 'Eggs', 'Parmesan', 'Black Pepper'],
    preparationTime: 15,
    isAvailable: true,
    isFeatured: false,
  ),

  // Salads
  Food(
    id: 'salad_1',
    name: 'Caesar Salad',
    description: 'Crisp romaine lettuce, croutons, parmesan, and creamy caesar dressing',
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&h=500&fit=crop',
    price: 9.99,
    rating: 4.5,
    reviewCount: 156,
    category: '6',
    ingredients: ['Romaine Lettuce', 'Croutons', 'Parmesan', 'Caesar Dressing'],
    preparationTime: 5,
    isAvailable: true,
    isFeatured: false,
  ),

  // Drinks
  Food(
    id: 'drink_1',
    name: 'Fresh Orange Juice',
    description: 'Freshly squeezed orange juice, no sugar added',
    image: 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500&h=500&fit=crop',
    price: 4.99,
    rating: 4.4,
    reviewCount: 124,
    category: '7',
    ingredients: ['Fresh Oranges'],
    sizes: ['Small (12oz)', 'Medium (16oz)', 'Large (20oz)'],
    preparationTime: 2,
    isAvailable: true,
    isFeatured: false,
  ),
  Food(
    id: 'drink_2',
    name: 'Iced Coffee',
    description: 'Cold brew coffee with ice and your choice of milk',
    image: 'https://images.unsplash.com/photo-1517668808822-9ebb02ae2a0e?w=500&h=500&fit=crop',
    price: 5.49,
    rating: 4.6,
    reviewCount: 267,
    category: '7',
    ingredients: ['Coffee', 'Milk', 'Ice'],
    sizes: ['Small', 'Medium', 'Large'],
    addOns: ['Extra Shot', 'Vanilla', 'Caramel'],
    preparationTime: 3,
    isAvailable: true,
    isFeatured: false,
  ),

  // Desserts
  Food(
    id: 'dessert_1',
    name: 'Chocolate Cake',
    description: 'Rich, moist chocolate cake with chocolate frosting and sprinkles',
    image: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=500&h=500&fit=crop',
    price: 6.99,
    rating: 4.9,
    reviewCount: 445,
    category: '8',
    ingredients: ['Chocolate', 'Flour', 'Eggs', 'Milk'],
    sizes: ['Slice', 'Half Cake', 'Whole Cake'],
    preparationTime: 5,
    isAvailable: true,
    isFeatured: true,
  ),
  Food(
    id: 'dessert_2',
    name: 'Vanilla Ice Cream',
    description: 'Creamy vanilla ice cream with your choice of toppings',
    image: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=500&h=500&fit=crop',
    price: 4.99,
    rating: 4.7,
    reviewCount: 334,
    category: '8',
    ingredients: ['Milk', 'Cream', 'Sugar', 'Vanilla'],
    sizes: ['Small', 'Medium', 'Large'],
    addOns: ['Sprinkles', 'Nuts', 'Chocolate Chips', 'Caramel Sauce'],
    preparationTime: 1,
    isAvailable: true,
    isFeatured: false,
  ),
];

/// Get foods by category
List<Food> getFoodsByCategory(String categoryId) {
  return mockFoods.where((food) => food.category == categoryId).toList();
}

/// Get featured foods
List<Food> getFeaturedFoods() {
  return mockFoods.where((food) => food.isFeatured).toList();
}

/// Get popular foods (highest rating)
List<Food> getPopularFoods() {
  final sorted = List<Food>.from(mockFoods);
  sorted.sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(6).toList();
}

/// Search foods by name or description
List<Food> searchFoods(String query) {
  final lowerQuery = query.toLowerCase();
  return mockFoods
      .where((food) =>
          food.name.toLowerCase().contains(lowerQuery) ||
          food.description.toLowerCase().contains(lowerQuery) ||
          food.ingredients.any((ing) => ing.toLowerCase().contains(lowerQuery)))
      .toList();
}

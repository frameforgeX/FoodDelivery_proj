import 'package:food_odering_app/models/order.dart';

/// Mock orders data
final List<Order> mockOrders = [
  Order(
    id: 'ORD-001',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    items: [
      {'foodName': 'Classic Cheeseburger', 'price': 8.99, 'quantity': 2},
      {'foodName': 'Iced Coffee', 'price': 5.49, 'quantity': 1},
    ],
    subtotal: 23.47,
    deliveryFee: 5.00,
    tax: 2.28,
    total: 30.75,
    status: 'delivered',
    deliveryMethod: 'delivery',
    paymentMethod: 'card',
    customerName: 'John Doe',
    customerPhone: '+1-555-0100',
    deliveryAddress: '123 Main St, New York, NY 10001',
    estimatedDeliveryTime: '30 mins',
  ),
  Order(
    id: 'ORD-002',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    items: [
      {'foodName': 'Margherita Pizza', 'price': 12.99, 'quantity': 1},
      {'foodName': 'Caesar Salad', 'price': 9.99, 'quantity': 1},
    ],
    subtotal: 22.98,
    deliveryFee: 5.00,
    tax: 2.24,
    total: 30.22,
    status: 'delivered',
    deliveryMethod: 'delivery',
    paymentMethod: 'mobile_money',
    customerName: 'John Doe',
    customerPhone: '+1-555-0100',
    deliveryAddress: '123 Main St, New York, NY 10001',
  ),
  Order(
    id: 'ORD-003',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    items: [
      {'foodName': 'Fried Chicken Combo', 'price': 11.99, 'quantity': 1},
      {'foodName': 'Fresh Orange Juice', 'price': 4.99, 'quantity': 2},
    ],
    subtotal: 21.97,
    deliveryFee: 5.00,
    tax: 2.15,
    total: 29.12,
    status: 'delivering',
    deliveryMethod: 'delivery',
    paymentMethod: 'cash',
    customerName: 'John Doe',
    customerPhone: '+1-555-0100',
    deliveryAddress: '123 Main St, New York, NY 10001',
    estimatedDeliveryTime: '15 mins',
  ),
  Order(
    id: 'ORD-004',
    createdAt: DateTime.now(),
    items: [
      {'foodName': 'Chocolate Cake', 'price': 6.99, 'quantity': 1},
      {'foodName': 'Vanilla Ice Cream', 'price': 4.99, 'quantity': 2},
    ],
    subtotal: 16.97,
    deliveryFee: 0.00,
    tax: 1.53,
    total: 18.50,
    status: 'preparing',
    deliveryMethod: 'pickup',
    paymentMethod: 'card',
    customerName: 'John Doe',
    customerPhone: '+1-555-0100',
    estimatedDeliveryTime: '20 mins',
  ),
];

/// Get orders by status
List<Order> getOrdersByStatus(String status) {
  return mockOrders.where((order) => order.status == status).toList();
}

/// Get recent orders
List<Order> getRecentOrders({int limit = 5}) {
  final sorted = List<Order>.from(mockOrders);
  sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return sorted.take(limit).toList();
}

/// Get order by ID
Order? getOrderById(String id) {
  try {
    return mockOrders.firstWhere((order) => order.id == id);
  } catch (e) {
    return null;
  }
}

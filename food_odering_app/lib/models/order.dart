import 'package:uuid/uuid.dart';

/// Order model
class Order {
  final String id;
  final DateTime createdAt;
  final List<Map<String, dynamic>> items; // {foodName, price, quantity}
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String status; // pending, preparing, ready, delivering, delivered, cancelled
  final String deliveryMethod; // delivery, pickup
  final String paymentMethod; // cash, card, mobile_money
  final String? customerName;
  final String? customerPhone;
  final String? deliveryAddress;
  final String? estimatedDeliveryTime;
  final String? specialInstructions;

  Order({
    String? id,
    DateTime? createdAt,
    required this.items,
    required this.subtotal,
    this.deliveryFee = 5.0,
    required this.tax,
    required this.total,
    this.status = 'pending',
    required this.deliveryMethod,
    required this.paymentMethod,
    this.customerName,
    this.customerPhone,
    this.deliveryAddress,
    this.estimatedDeliveryTime,
    this.specialInstructions,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Order copyWith({
    String? id,
    DateTime? createdAt,
    List<Map<String, dynamic>>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? total,
    String? status,
    String? deliveryMethod,
    String? paymentMethod,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
    String? estimatedDeliveryTime,
    String? specialInstructions,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  String get statusDisplayText {
    switch (status) {
      case 'pending':
        return 'Processing';
      case 'preparing':
        return 'Preparing';
      case 'ready':
        return 'Ready';
      case 'delivering':
        return 'On the way';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  @override
  String toString() => 'Order(id: $id, total: $total, status: $status)';
}

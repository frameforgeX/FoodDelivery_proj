import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';
import 'package:food_odering_app/core/constants/app_spacing.dart';
import 'package:food_odering_app/features/cart/providers/cart_provider.dart';
import 'package:food_odering_app/models/order.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final nameController = TextEditingController(text: 'John Doe');
  final phoneController = TextEditingController(text: '+1 555 0100');
  final addressController = TextEditingController(text: '123 Main St, New York, NY 10001');
  final instructionsController = TextEditingController();

  String deliveryMethod = 'delivery';
  String paymentMethod = 'card';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final total = ref.watch(cartTotalProvider);

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(child: Text('Your cart is empty')), 
      );
    }

    final deliveryFee = 5.0;
    final tax = total * 0.08;
    final finalTotal = total + deliveryFee + tax;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Delivery address'),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Delivery method',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Delivery'),
                    selected: deliveryMethod == 'delivery',
                    onSelected: (_) => setState(() => deliveryMethod = 'delivery'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Pickup'),
                    selected: deliveryMethod == 'pickup',
                    onSelected: (_) => setState(() => deliveryMethod = 'pickup'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Payment method',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                ChoiceChip(
                  label: const Text('Card'),
                  selected: paymentMethod == 'card',
                  onSelected: (_) => setState(() => paymentMethod = 'card'),
                ),
                ChoiceChip(
                  label: const Text('Mobile money'),
                  selected: paymentMethod == 'mobile_money',
                  onSelected: (_) => setState(() => paymentMethod = 'mobile_money'),
                ),
                ChoiceChip(
                  label: const Text('Cash'),
                  selected: paymentMethod == 'cash',
                  onSelected: (_) => setState(() => paymentMethod = 'cash'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: instructionsController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Special instructions',
                hintText: 'Gate code or allergy note',
                filled: true,
                fillColor: AppColors.greyLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _summaryRow('Subtotal', subtotal),
                  _summaryRow('Delivery', deliveryFee),
                  _summaryRow('Tax', tax),
                  const Divider(height: 24),
                  _summaryRow('Total', finalTotal, isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
        child: FilledButton(
          onPressed: () {
            final orderId = const Uuid().v4().substring(0, 8).toUpperCase();
            final order = Order(
              id: orderId,
              items: cart
                  .map((item) => {
                        'foodName': item.foodName,
                        'price': item.price,
                        'quantity': item.quantity,
                      })
                  .toList(),
              subtotal: subtotal,
              deliveryFee: deliveryFee,
              tax: tax,
              total: finalTotal,
              status: 'pending',
              deliveryMethod: deliveryMethod,
              paymentMethod: paymentMethod,
              customerName: nameController.text.trim().isEmpty ? 'John Doe' : nameController.text.trim(),
              customerPhone: phoneController.text.trim().isEmpty ? '+1 555 0100' : phoneController.text.trim(),
              deliveryAddress: addressController.text.trim().isEmpty ? '123 Main St, New York, NY 10001' : addressController.text.trim(),
              estimatedDeliveryTime: deliveryMethod == 'pickup' ? '20 mins' : '30 mins',
              specialInstructions: instructionsController.text.trim().isEmpty ? null : instructionsController.text.trim(),
            );

            ref.read(cartProvider.notifier).clearCart();
            context.push('/order-confirmation?orderId=${order.id}');
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('Place order'),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

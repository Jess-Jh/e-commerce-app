import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class QuantitySelector extends ConsumerWidget {
  final Product product;

  const QuantitySelector({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    final quantity = cart[product.id]?.quantity ?? 0;
    final isExpress = cartNotifier.isExpress;

    final color = isExpress ? Colors.blue : Colors.orange;

    if (quantity == 0) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          cartNotifier.addProduct(product);
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text("Add to Cart"),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline, color: color),
            onPressed: () => cartNotifier.removeProduct(product.id),
            visualDensity: VisualDensity.compact,
          ),
          Spacer(),
          Text(
            '$quantity und',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: color),
            onPressed: () => cartNotifier.addProduct(product),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

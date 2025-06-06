import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';

class CartIcon extends ConsumerWidget {
  final VoidCallback? onTap;

  const CartIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);
    final controller = ref.read(cartControllerProvider.notifier);

    final itemCount = cartItems.values.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );
    final isExpress = controller.isExpress;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap ?? () {},
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
              right: 12,
              left: 12,
            ),
            child: Icon(
              Icons.shopping_cart,
              color: isExpress ? Colors.blue : Colors.orange,
              size: 24,
            ),
          ),
        ),

        // Badge de cantidad
        if (itemCount > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                itemCount > 9 ? '9+' : '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

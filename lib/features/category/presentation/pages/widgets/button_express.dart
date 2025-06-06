import 'package:ecommerce_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonExpress extends ConsumerWidget {
  const ButtonExpress({super.key, required this.isExpress});

  final bool isExpress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isExpress
              ? [Colors.blue.shade400, Colors.blue.shade700]
              : [Colors.white, Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isExpress
                ? const Color.fromRGBO(21, 101, 192, 0.2)
                : Colors.black12,
            blurRadius: isExpress ? 8 : 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: isExpress ? Colors.white : Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isExpress
                    ? 'Deactivate express experience'
                    : 'Activate the express experience',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isExpress ? Colors.white : Colors.blue.shade800,
                ),
              ),
            ],
          ),
          Switch(
            value: isExpress,
            activeColor: Colors.white,
            activeTrackColor: Colors.blue.shade300,
            inactiveThumbColor: Colors.grey.shade300,
            inactiveTrackColor: Colors.grey.shade200,
            onChanged: (value) {
              cartController.toggleMode(value);
            },
          ),
        ],
      ),
    );
  }
}

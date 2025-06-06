import 'package:ecommerce_app/core/utils/util.dart';
import 'package:ecommerce_app/features/cart/presentation/pages/cart_summary_page.dart';
import 'package:ecommerce_app/features/cart/presentation/pages/widgets/cart_icon.dart';
import 'package:ecommerce_app/features/product/presentation/pages/widgets/product_grid_item.dart';
import 'package:ecommerce_app/features/product/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductListPage extends ConsumerWidget {
  final String category;
  static const routeName = 'product-list';

  const ProductListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListProvider(category));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CartIcon(
              onTap: () => context.pushNamed(CartSummaryPage.routeName),
            ),
          ),
        ],

        title: Text(
          category.toCapitalized(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('There are no products.'));
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Productos
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    childAspectRatio: 0.51,
                    children: products
                        .map((product) => ProductGridItem(product: product))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

import 'package:ecommerce_app/core/utils/is_express_time_active.dart';
import 'package:ecommerce_app/core/utils/util.dart';
import 'package:ecommerce_app/features/cart/presentation/pages/cart_summary_page.dart';
import 'package:ecommerce_app/features/cart/presentation/pages/widgets/cart_icon.dart';
import 'package:ecommerce_app/features/category/presentation/pages/widgets/button_express.dart';
import 'package:ecommerce_app/features/product/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/category_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});
  static const routeName = 'products';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);
    final cartController = ref.watch(cartControllerProvider.notifier);
    final isExpress = ref.watch(
      cartControllerProvider.select((state) => cartController.isExpress),
    );
    final isExpressAvailable = isExpressTimeActive();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-Commerce',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CartIcon(
              onTap: () => context.pushNamed(CartSummaryPage.routeName),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: categoriesAsync.when(
        data: (categories) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 12,
              right: 12,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isExpressAvailable) ButtonExpress(isExpress: isExpress),

                const SizedBox(height: 28),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.84,
                    children: categories.map((category) {
                      return Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.pushNamed(
                                ProductListPage.routeName,
                                pathParameters: {
                                  'category': category.name.toLowerCase(),
                                },
                              );
                            },
                            child: Card(
                              color: const Color.fromARGB(235, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 1.5,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F4F4),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          category.imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.name.toCapitalized(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    }).toList(),
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

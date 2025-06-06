import 'package:ecommerce_app/features/cart/presentation/pages/cart_summary_page.dart';
import 'package:ecommerce_app/features/category/presentation/pages/category_page.dart';
import 'package:ecommerce_app/features/product/presentation/pages/product_list_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: CategoryPage.routeName,
        builder: (context, state) => const CategoryPage(),
      ),
      GoRoute(
        path: '/products/:category',
        name: ProductListPage.routeName,
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return ProductListPage(category: category);
        },
      ),
      GoRoute(
        path: '/cart',
        name: CartSummaryPage.routeName,
        builder: (context, state) => const CartSummaryPage(),
      ),
    ],
  );
}

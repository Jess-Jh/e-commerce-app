import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_provider.g.dart';

enum CartMode { normal, express }

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  Map<int, CartItem>? _normalCart;
  Map<int, CartItem>? _expressCart;
  CartMode _mode = CartMode.normal;

  @override
  Map<int, CartItem> build() {
    _normalCart ??= {};
    _expressCart ??= {};
    return _currentCart;
  }

  void toggleMode(bool isExpress) {
    if (isExpress && !isExpressTimeActive()) {
      // Ignora si no está dentro del horario express
      return;
    }

    _mode = isExpress ? CartMode.express : CartMode.normal;
    _updateState();
  }

  bool isExpressTimeActive() {
    final now = DateTime.now();
    return now.hour >= 10 && now.hour < 16;
  }

  void addProduct(Product product) {
    final cart = _currentCart;
    final id = product.id;

    cart[id] = cart.containsKey(id)
        ? cart[id]!.copyWith(quantity: cart[id]!.quantity + 1)
        : CartItem(product: product, quantity: 1);

    _updateState();
  }

  void removeProduct(int productId) {
    final cart = _currentCart;

    if (cart.containsKey(productId)) {
      final quantity = cart[productId]!.quantity;
      if (quantity > 1) {
        cart[productId] = cart[productId]!.copyWith(quantity: quantity - 1);
      } else {
        cart.remove(productId);
      }
    }

    _updateState();
  }

  bool get isExpress => _mode == CartMode.express;
  CartMode get mode => _mode;

  int get totalItems =>
      _currentCart.values.fold(0, (sum, item) => sum + item.quantity);

  Map<int, CartItem> get _currentCart =>
      _mode == CartMode.normal ? _normalCart! : _expressCart!;

  void _updateState() {
    state = Map<int, CartItem>.from(_currentCart);
  }
}

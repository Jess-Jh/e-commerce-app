import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
sealed class CartItem with _$CartItem {
  const factory CartItem({required Product product, required int quantity}) =
      _CartItem;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
sealed class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required String image,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  Product toEntity() => Product(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    image: image,
  );
}

extension ProductX on Product {
  ProductModel toModel() => ProductModel(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    image: image,
  );
}

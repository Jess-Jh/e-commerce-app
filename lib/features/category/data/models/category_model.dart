import 'package:ecommerce_app/features/category/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
sealed class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String name,
    required String imageUrl,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelX on CategoryModel {
  Category toEntity() => Category(name: name, imageUrl: imageUrl);
}

extension CategoryX on Category {
  CategoryModel toModel() => CategoryModel(name: name, imageUrl: imageUrl);
}

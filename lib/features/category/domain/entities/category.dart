import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
sealed class Category with _$Category {
  const factory Category({required String name, required String imageUrl}) =
      _Category;
}

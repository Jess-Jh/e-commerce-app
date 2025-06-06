import 'package:ecommerce_app/core/di.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
Future<List<Product>> productList(Ref ref, String category) async {
  final useCase = ref.watch(getProductsByCategoryUseCaseProvider);
  return useCase(category);
}

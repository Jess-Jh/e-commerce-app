import 'package:ecommerce_app/core/di.dart';
import 'package:ecommerce_app/features/category/domain/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
Future<List<Category>> categoryList(Ref ref) async {
  final useCase = ref.watch(getAllCategoriesUseCaseProvider);
  return useCase();
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/features/category/data/datasource/category_remote_data_source.dart';
import 'package:ecommerce_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/category/domain/use_cases/get_all_categories.dart';
import 'package:ecommerce_app/features/category/domain/repositories/category_repository.dart';

import 'package:ecommerce_app/features/product/data/datasource/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/use_cases/get_products_by_category.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

part 'di.g.dart';

// Dio
@Riverpod(keepAlive: true)
Dio dio(Ref ref) => Dio();

// Category

@Riverpod(keepAlive: true)
CategoryRemoteDataSource categoryRemoteDataSource(Ref ref) {
  return CategoryRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) {
  return CategoryRepositoryImpl(ref.watch(categoryRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetAllCategories getAllCategoriesUseCase(Ref ref) {
  return GetAllCategories(ref.watch(categoryRepositoryProvider));
}

// Product

@Riverpod(keepAlive: true)
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  return ProductRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetProductsByCategory getProductsByCategoryUseCase(Ref ref) {
  return GetProductsByCategory(ref.watch(productRepositoryProvider));
}

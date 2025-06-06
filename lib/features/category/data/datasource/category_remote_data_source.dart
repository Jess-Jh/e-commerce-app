import 'package:dio/dio.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await dio.get(
      'https://fakestoreapi.com/products/categories',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }

    final List<dynamic> categoryNames = response.data;
    final List<CategoryModel> result = [];

    for (final name in categoryNames) {
      final productResponse = await dio.get(
        'https://fakestoreapi.com/products/category/${Uri.encodeComponent(name)}',
      );

      if (productResponse.statusCode == 200) {
        final products = productResponse.data as List;

        if (products.isNotEmpty) {
          final firstProduct = products[1];
          final image = firstProduct['image'] ?? '';

          result.add(CategoryModel(name: name.toString(), imageUrl: image));
        }
      }
    }

    return result;
  }
}

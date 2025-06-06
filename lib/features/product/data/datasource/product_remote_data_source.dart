import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getByCategory(String category) async {
    final encoded = Uri.encodeComponent(category);
    final response = await dio.get(
      'https://fakestoreapi.com/products/category/$encoded',
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

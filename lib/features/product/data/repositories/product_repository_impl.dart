import 'package:ecommerce_app/features/product/data/models/product_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getByCategory(String category) async {
    final models = await remoteDataSource.getByCategory(category);
    return models.map((m) => m.toEntity()).toList();
  }
}

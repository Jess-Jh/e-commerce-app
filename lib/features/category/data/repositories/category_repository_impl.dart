import 'package:ecommerce_app/features/category/data/models/category_model.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/domain/repositories/category_repository.dart';
import '../datasource/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getAllCategories() async {
    final models = await remoteDataSource.getAllCategories();
    return models.map((m) => m.toEntity()).toList();
  }
}

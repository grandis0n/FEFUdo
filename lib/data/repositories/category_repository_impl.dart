import 'package:drift/drift.dart';
import 'package:fefu_do/data/database.dart' as db;
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';

import '../datasources/category_local_data_source.dart';


class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final categories = await localDataSource.getAllCategories();
    return categories.map((e) => Category(
      id: e.id,
      name: e.name,
      createdAt: e.createdAt,
    )).toList();
  }

  @override
  Future<void> addCategory(Category category) async {
    final categoryCompanion = db.CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      createdAt: Value(category.createdAt),
    );
    await localDataSource.insertCategory(categoryCompanion);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await localDataSource.deleteCategory(id);
  }

  @override
  Future<void> updateCategory(Category category) async {
    final categoryCompanion = db.CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      createdAt: Value(category.createdAt),
    );
    await localDataSource.updateCategory(categoryCompanion);
  }
}
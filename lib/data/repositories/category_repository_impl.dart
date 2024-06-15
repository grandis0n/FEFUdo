import 'package:drift/drift.dart';
import 'package:fefu_do/data/database.dart' as db;
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final db.AppDatabase database;

  CategoryRepositoryImpl(this.database);

  @override
  Future<List<Category>> getCategories() async {
    final categories = await database.getAllCategories();
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
    await database.insertCategory(categoryCompanion);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await database.deleteCategory(id);
  }

  @override
  Future<void> updateCategory(Category category) async {
    final categoryCompanion = db.CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      createdAt: Value(category.createdAt),
    );
    await database.updateCategory(categoryCompanion);
  }
}

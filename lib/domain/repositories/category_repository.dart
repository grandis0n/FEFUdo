import 'package:fefu_do/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<void> updateCategory(Category category);
}
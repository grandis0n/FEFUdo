import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';

class AddCategory {
  final CategoryRepository repository;

  AddCategory(this.repository);

  Future<void> call(Category category) async {
    await repository.addCategory(category);
  }
}
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  Future<void> call(Category category) async {
    await repository.updateCategory(category);
  }
}

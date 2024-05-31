import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}
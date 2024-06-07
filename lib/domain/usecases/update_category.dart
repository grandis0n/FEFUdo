import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';
import 'package:fefu_do/domain/usecases/usecase.dart';

import '../../core/error/failures.dart';

class UpdateCategory extends UseCase<void, Category> {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  @override
  Future<Either<Failure, void>> call(Category category) async {
    try {
      await repository.updateCategory(category);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';
import 'package:fefu_do/domain/usecases/usecase.dart';

import '../../core/error/failures.dart';

class DeleteCategory extends UseCase<void, String> {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    try {
      await repository.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

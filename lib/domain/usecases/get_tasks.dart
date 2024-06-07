import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/entities/task.dart' as task_entity;
import 'package:fefu_do/domain/repositories/task_repository.dart';
import 'package:fefu_do/domain/usecases/usecase.dart';

import '../../core/error/failures.dart';

class GetTasks extends UseCase<List<task_entity.Task>, String> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<Either<Failure, List<task_entity.Task>>> call(String categoryId) async {
    try {
      final tasks = await repository.getTasks(categoryId);
      return Right(tasks);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

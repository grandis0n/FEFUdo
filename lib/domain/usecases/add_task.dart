import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/entities/task.dart' as task_entity;
import 'package:fefu_do/domain/repositories/task_repository.dart';
import 'package:fefu_do/domain/usecases/usecase.dart';

import '../../core/error/failures.dart';

class AddTask extends UseCase<void, task_entity.Task> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Future<Either<Failure, void>> call(task_entity.Task task) async {
    try {
      await repository.addTask(task);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

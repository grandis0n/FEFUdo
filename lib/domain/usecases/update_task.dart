import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task);
  }
}
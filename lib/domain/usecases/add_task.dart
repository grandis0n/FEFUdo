import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/domain/repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    await repository.addTask(task);
  }
}
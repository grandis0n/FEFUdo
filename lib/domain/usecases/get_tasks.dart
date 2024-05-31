import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call(String categoryId) async {
    return await repository.getTasks(categoryId);
  }
}
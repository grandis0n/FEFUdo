import 'package:drift/drift.dart';
import 'package:fefu_do/data/database.dart' as db;
import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/domain/repositories/task_repository.dart';

import '../datasources/task_local_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks(String categoryId) async {
    final tasks = await localDataSource.getTasksByCategoryId(categoryId);
    return tasks.map((e) => Task(
      id: e.id,
      title: e.title,
      description: e.description,
      isCompleted: e.isCompleted,
      isFavourite: e.isFavourite,
      categoryId: e.categoryId,
      createdAt: e.createdAt,
      imageUrl: e.imageUrl,
    )).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskCompanion = db.TasksCompanion(
      id: Value(task.id),
      title: Value(task.title),
      description: Value(task.description),
      isCompleted: Value(task.isCompleted),
      isFavourite: Value(task.isFavourite),
      categoryId: Value(task.categoryId),
      createdAt: Value(task.createdAt),
      imageUrl: Value(task.imageUrl),
    );
    await localDataSource.insertTask(taskCompanion);
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskCompanion = db.TasksCompanion(
      id: Value(task.id),
      title: Value(task.title),
      description: Value(task.description),
      isCompleted: Value(task.isCompleted),
      isFavourite: Value(task.isFavourite),
      categoryId: Value(task.categoryId),
      createdAt: Value(task.createdAt),
      imageUrl: Value(task.imageUrl),
    );
    await localDataSource.updateTask(taskCompanion);
  }
}

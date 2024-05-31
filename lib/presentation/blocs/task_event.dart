import 'package:equatable/equatable.dart';
import 'package:fefu_do/domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  final String categoryId;

  const LoadTasks(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class AddNewTask extends TaskEvent {
  final Task task;

  const AddNewTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object> get props => [id];
}

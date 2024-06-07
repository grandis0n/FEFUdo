import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:fefu_do/domain/usecases/add_task.dart';
import 'package:fefu_do/domain/usecases/delete_task.dart';
import 'package:fefu_do/domain/usecases/get_tasks.dart';
import 'package:fefu_do/domain/usecases/update_task.dart';
import 'package:fefu_do/presentation/blocs/task_event.dart';
import 'package:fefu_do/presentation/blocs/task_state.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/task.dart' as task_entity;

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      final Either<Failure, List<task_entity.Task>> result = await getTasks(event.categoryId);
      result.fold(
            (failure) => emit(TaskError(failure.toString())),
            (tasks) => emit(TaskLoaded(tasks)),
      );
    });

    on<AddNewTask>((event, emit) async {
      emit(TaskLoading());
      final Either<Failure, void> result = await addTask(event.task);
      result.fold(
            (failure) => emit(TaskError(failure.toString())),
            (_) async {
          final Either<Failure, List<task_entity.Task>> result = await getTasks(event.task.categoryId);
          result.fold(
                (failure) => emit(TaskError(failure.toString())),
                (tasks) => emit(TaskLoaded(tasks)),
          );
        },
      );
    });

    on<UpdateTaskEvent>((event, emit) async {
      final Either<Failure, void> result = await updateTask(event.task);
      result.fold(
            (failure) => emit(TaskError(failure.toString())),
            (_) async {
          final Either<Failure, List<task_entity.Task>> result = await getTasks(event.task.categoryId);
          result.fold(
                (failure) => emit(TaskError(failure.toString())),
                (tasks) => emit(TaskLoaded(tasks)),
          );
        },
      );
    });

    on<DeleteTaskEvent>((event, emit) async {
      final Either<Failure, void> result = await deleteTask(event.id);
      result.fold(
            (failure) => emit(TaskError(failure.toString())),
            (_) async {
          final categoryId = state is TaskLoaded
              ? (state as TaskLoaded).tasks.firstWhere((task) => task.id == event.id).categoryId
              : '';
          final Either<Failure, List<task_entity.Task>> result = await getTasks(categoryId);
          result.fold(
                (failure) => emit(TaskError(failure.toString())),
                (tasks) => emit(TaskLoaded(tasks)),
          );
        },
      );
    });
  }
}

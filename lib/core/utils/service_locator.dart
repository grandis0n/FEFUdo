import 'package:get_it/get_it.dart';
import 'package:fefu_do/data/repositories/category_repository_impl.dart';
import 'package:fefu_do/data/repositories/task_repository_impl.dart';
import 'package:fefu_do/domain/repositories/category_repository.dart';
import 'package:fefu_do/domain/repositories/task_repository.dart';
import 'package:fefu_do/domain/usecases/add_category.dart';
import 'package:fefu_do/domain/usecases/add_task.dart';
import 'package:fefu_do/domain/usecases/delete_category.dart';
import 'package:fefu_do/domain/usecases/delete_task.dart';
import 'package:fefu_do/domain/usecases/get_categories.dart';
import 'package:fefu_do/domain/usecases/get_tasks.dart';
import 'package:fefu_do/domain/usecases/update_category.dart';
import 'package:fefu_do/domain/usecases/update_task.dart';
import 'package:fefu_do/presentation/blocs/category_bloc.dart';
import 'package:fefu_do/presentation/blocs/task_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Repositories
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  // UseCases
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => DeleteCategory(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => UpdateCategory(sl()));

  // Blocs
  sl.registerFactory(() => CategoryBloc(
    getCategories: sl(),
    addCategory: sl(),
    deleteCategory: sl(),
    updateCategory: sl(),
  ));

  sl.registerFactory(() => TaskBloc(
    getTasks: sl(),
    addTask: sl(),
    updateTask: sl(),
    deleteTask: sl(),
  ));
}

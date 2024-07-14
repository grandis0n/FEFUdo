import 'package:get_it/get_it.dart';
import 'package:fefu_do/data/datasources/category_local_data_source.dart';
import 'package:fefu_do/data/datasources/task_local_data_source.dart';
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
import 'package:fefu_do/presentation/cubits/category_cubit.dart';
import 'package:fefu_do/presentation/cubits/task_cubit.dart';
import 'package:fefu_do/data/database.dart';
import '../../data/datasources/flickr_service.dart';
import '../../presentation/cubits/image_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data Sources
  sl.registerLazySingleton<CategoryLocalDataSource>(() => CategoryLocalDataSource(sl()));
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => DeleteCategory(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => UpdateCategory(sl()));

  // Cubits
  sl.registerFactory(() => CategoryCubit(
    getCategories: sl(),
    addCategory: sl(),
    deleteCategory: sl(),
    updateCategory: sl(),
  ));

  sl.registerFactory(() => TaskCubit(
    getTasks: sl(),
    addTask: sl(),
    updateTask: sl(),
    deleteTask: sl(),
  ));

  // Services
  sl.registerLazySingleton<FlickrService>(() => FlickrService());

  // ImageCubit
  sl.registerFactory(() => ImageCubit(sl<FlickrService>()));
}

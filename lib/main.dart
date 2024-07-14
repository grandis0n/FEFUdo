import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fefu_do/core/utils/service_locator.dart';
import 'package:fefu_do/presentation/screens/categories_screen.dart';
import 'package:fefu_do/presentation/cubits/category_cubit.dart';
import 'package:fefu_do/presentation/cubits/task_cubit.dart';
import 'package:fefu_do/presentation/cubits/image_cubit.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(
          create: (context) => GetIt.I<CategoryCubit>()..loadCategories(),
        ),
        BlocProvider<TaskCubit>(
          create: (context) => GetIt.I<TaskCubit>(),
        ),
        BlocProvider<ImageCubit>(
          create: (context) => GetIt.I<ImageCubit>(),
        ),
      ],
      child: const MaterialApp(
        home: CategoriesScreen(),
      ),
    );
  }
}

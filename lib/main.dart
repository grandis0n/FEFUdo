import 'package:fefu_do/presentation/blocs/category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fefu_do/core/utils/service_locator.dart';
import 'package:fefu_do/presentation/screens/categories_screen.dart';
import 'package:fefu_do/presentation/blocs/category_bloc.dart';
import 'package:fefu_do/presentation/blocs/task_bloc.dart';
import 'package:get_it/get_it.dart';

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
        BlocProvider<CategoryBloc>(
          create: (context) => GetIt.I<CategoryBloc>()..add(LoadCategories()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => GetIt.I<TaskBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: CategoriesScreen(),
      ),
    );
  }
}

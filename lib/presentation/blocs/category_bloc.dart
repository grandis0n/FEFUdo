import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/usecases/add_category.dart';
import 'package:fefu_do/domain/usecases/delete_category.dart';
import 'package:fefu_do/domain/usecases/get_categories.dart';
import 'package:fefu_do/domain/usecases/update_category.dart';
import 'package:fefu_do/core/error/failures.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final DeleteCategory deleteCategory;
  final UpdateCategory updateCategory;

  CategoryBloc({
    required this.getCategories,
    required this.addCategory,
    required this.deleteCategory,
    required this.updateCategory,
  }) : super(CategoryState.initial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryState.loading());
      final Either<Failure, List<Category>> result = await getCategories(NoParams());
      result.fold(
            (failure) => emit(CategoryState.error(failure.message)),
            (categories) => emit(CategoryState.loaded(categories)),
      );
    });

    on<AddNewCategory>((event, emit) async {
      final Either<Failure, void> result = await addCategory(event.category);
      result.fold(
            (failure) => emit(CategoryState.error(failure.message)),
            (_) => add(LoadCategories()),
      );
    });

    on<DeleteCategoryEvent>((event, emit) async {
      final Either<Failure, void> result = await deleteCategory(event.id);
      result.fold(
            (failure) => emit(CategoryState.error(failure.message)),
            (_) => add(LoadCategories()),
      );
    });

    on<UpdateCategoryEvent>((event, emit) async {
      final Either<Failure, void> result = await updateCategory(event.category);
      result.fold(
            (failure) => emit(CategoryState.error(failure.message)),
            (_) => add(LoadCategories()),
      );
    });
  }
}

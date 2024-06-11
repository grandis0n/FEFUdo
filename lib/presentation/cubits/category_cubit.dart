import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fefu_do/domain/entities/category.dart';
import 'package:fefu_do/domain/usecases/add_category.dart';
import 'package:fefu_do/domain/usecases/delete_category.dart';
import 'package:fefu_do/domain/usecases/get_categories.dart';
import 'package:fefu_do/domain/usecases/update_category.dart';
import 'package:fefu_do/core/error/failures.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final DeleteCategory deleteCategory;
  final UpdateCategory updateCategory;

  CategoryCubit({
    required this.getCategories,
    required this.addCategory,
    required this.deleteCategory,
    required this.updateCategory,
  }) : super(CategoryState.initial());

  void loadCategories() async {
    emit(CategoryState.loading());
    final Either<Failure, List<Category>> result = await getCategories(NoParams());
    result.fold(
          (failure) => emit(CategoryState.error(failure.message)),
          (categories) => emit(CategoryState.loaded(categories)),
    );
  }

  void addNewCategory(Category category) async {
    final Either<Failure, void> result = await addCategory(category);
    result.fold(
          (failure) => emit(CategoryState.error(failure.message)),
          (_) => loadCategories(),
    );
  }

  void deleteCategoryById(String id) async {
    final Either<Failure, void> result = await deleteCategory(id);
    result.fold(
          (failure) => emit(CategoryState.error(failure.message)),
          (_) => loadCategories(),
    );
  }

  void modifyCategory(Category category) async {
    final Either<Failure, void> result = await updateCategory(category);
    result.fold(
          (failure) => emit(CategoryState.error(failure.message)),
          (_) => loadCategories(),
    );
  }
}

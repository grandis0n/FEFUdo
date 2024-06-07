import 'package:equatable/equatable.dart';
import 'package:fefu_do/domain/entities/category.dart';

enum CategoryStatus { initial, loading, loaded, error }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<Category> categories;
  final String message;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.categories = const [],
    this.message = '',
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<Category>? categories,
    String? message,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message ?? this.message,
    );
  }

  static CategoryState initial() {
    return const CategoryState(status: CategoryStatus.initial);
  }

  static CategoryState loading() {
    return const CategoryState(status: CategoryStatus.loading);
  }

  static CategoryState loaded(List<Category> categories) {
    return CategoryState(status: CategoryStatus.loaded, categories: categories);
  }

  static CategoryState error(String message) {
    return CategoryState(status: CategoryStatus.error, message: message);
  }

  @override
  List<Object?> get props => [status, categories, message];
}

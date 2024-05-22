import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String? description;
  bool isCompleted;
  bool isFavourite;
  String categoryId;

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.isFavourite = false,
    required this.categoryId,
  }) : id = const Uuid().v4();
}

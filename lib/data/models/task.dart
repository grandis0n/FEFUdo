import 'package:uuid/uuid.dart';

class Task {
  String id = const Uuid().v4();
  String title;
  String? description;
  bool isCompleted;
  bool isFavourite;
  DateTime createdAt = DateTime.now();
  String categoryId;

  Task({
    required this.title,
    this.description,
    required this.isCompleted,
    required this.isFavourite,
    required this.createdAt,
    required this.categoryId,
  });
}

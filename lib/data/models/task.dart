import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String? description;
  bool isCompleted;
  bool isFavourite;
  String categoryId;
  DateTime createdAt;

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.isFavourite = false,
    required this.categoryId,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now();

  void update({required String title, String? description}) {
    this.title = title;
    this.description = description;
  }
}

import 'package:uuid/uuid.dart';

class Category {
  String id = const Uuid().v4();
  String name;
  DateTime createdAt = DateTime.now();

  Category({
    required this.name,
    required this.createdAt,
  });
}

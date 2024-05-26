import 'package:uuid/uuid.dart';

class Category {
  String id;
  String name;
  DateTime createdAt;

  Category({
    required this.name,
    String? id,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();
}

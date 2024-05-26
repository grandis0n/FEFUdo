import 'package:uuid/uuid.dart';

class Category {
  String id;
  String name;
  DateTime createdAt;

  Category({
    required this.name,
  })  : id = const Uuid().v4(),
        createdAt =  DateTime.now();
}

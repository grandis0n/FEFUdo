class Task {
  final String id;
  String title;
  String? description;
  bool isCompleted;
  bool isFavourite;
  final String categoryId;
  final DateTime createdAt;
  String? imageUrl;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.isFavourite,
    required this.categoryId,
    required this.createdAt,
    this.imageUrl,
  });

  void update({
    required String title,
    String? description,
    String? imageUrl,
  }) {
    this.title = title;
    this.description = description;
    this.imageUrl = imageUrl ?? this.imageUrl;
  }
}
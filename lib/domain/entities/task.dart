class Task {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final bool isFavourite;
  final String categoryId;
  final DateTime createdAt;
  final String? imageUrl;

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

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    bool? isFavourite,
    String? imageUrl,
  }) {
    return Task(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavourite: isFavourite ?? this.isFavourite,
      categoryId: this.categoryId,
      createdAt: this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

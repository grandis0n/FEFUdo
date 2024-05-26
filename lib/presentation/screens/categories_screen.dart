import 'package:fefu_do/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var categories = <Category>[];

  void _addNewCategory() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: const Text('Добавить категорию'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Название категории',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    categories.add(Category(name: name));
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FEFU Todo App'),
        backgroundColor: Colors.blue,
      ),
      body: categories.isNotEmpty
          ? ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  category: category,
                  onDismissed: () {
                    setState(() {
                      categories.removeAt(index);
                    });
                  },
                  onEdit: (newName) {
                    setState(() {
                      categories[index].name = newName;
                    });
                  },
                );
              },
            )
          : const Center(
              child: Text('Список категорий пуст'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.onDismissed,
    required this.onEdit,
  }) : super(key: key);

  final Category category;
  final Function() onDismissed;
  final Function(String) onEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TasksScreen(category: category),
            ),
          );
        },
        child: Dismissible(
          key: Key(category.name),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Редактировать категорию'),
                    content: TextField(
                      onChanged: (newValue) {
                        onEdit(newValue);
                      },
                      controller: TextEditingController(text: category.name),
                      decoration: InputDecoration(
                        hintText: 'Новое название категории',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Сохранить'),
                      ),
                    ],
                  );
                },
              );
            } else {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Удалить категорию'),
                    content: Text(
                        'Вы уверены, что хотите удалить категорию "${category.name}"?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Удалить'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              onDismissed();
            }
          },
          background: Container(
            color: Colors.orange,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(left: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.chrome_reader_mode),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

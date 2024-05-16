import 'package:fefu_do/data/models/category.dart';
import 'package:fefu_do/data/models/task.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  final Category category;

  const TasksScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> allTasks = [];
  List<Task> filteredTasks = [];

  String currentFilter = "All";

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController titleController = TextEditingController();
        final TextEditingController descriptionController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Название задачи',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Описание задачи (необязательно)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                if (title.isNotEmpty) {
                  setState(() {
                    allTasks.add(Task(
                      title: title,
                      description: description.isEmpty ? null : description,
                      isCompleted: false,
                      isFavourite: false,
                      categoryId: widget.category.id,
                    ));
                  });
                  _updateFilteredTasks();
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

  void _deleteTask(Task task) {
    setState(() {
      allTasks.remove(task);
      _updateFilteredTasks();
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      _updateFilteredTasks();
    });
  }

  void _toggleFavorite(Task task) {
    setState(() {
      task.isFavourite = !task.isFavourite;
      _updateFilteredTasks();
    });
  }

  void _updateFilteredTasks() {
    filteredTasks.clear();
    if (currentFilter == "All") {
      filteredTasks.addAll(allTasks);
    } else if (currentFilter == "Completed") {
      filteredTasks.addAll(allTasks.where((task) => task.isCompleted));
    } else if (currentFilter == "Uncompleted") {
      filteredTasks.addAll(allTasks.where((task) => !task.isCompleted));
    } else if (currentFilter == "Favorites") {
      filteredTasks.addAll(allTasks.where((task) => task.isFavourite));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() {
              currentFilter = value;
              _updateFilteredTasks();
            }),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "All",
                child: Text('Все'),
              ),
              const PopupMenuItem(
                value: "Completed",
                child: Text('Завершенные'),
              ),
              const PopupMenuItem(
                value: "Uncompleted",
                child: Text('Незавершенные'),
              ),
              const PopupMenuItem(
                value: "Favorites",
                child: Text('Избранные'),
              ),
            ],
          ),
        ],
      ),
      body: filteredTasks.isNotEmpty
          ? ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return TaskCard(
            task: task,
            onDelete: () => _deleteTask(task),
            onToggleCompletion: () => _toggleTaskCompletion(task),
            onToggleFavorite: () => _toggleFavorite(task),
          );
        },
      )
          : const Center(
        child: Text('Список задач пуст'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final Function() onDelete;
  final Function() onToggleFavorite;
  final Function() onToggleCompletion;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onToggleCompletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.check,
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
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        } else if (direction == DismissDirection.startToEnd) {
          // for editing
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (newValue) => onToggleCompletion(),
            ),
            Text(task.title),
            IconButton(
              icon: Icon(
                task.isFavourite ? Icons.star : Icons.star_outline,
                color: task.isFavourite ? Colors.yellow : Colors.grey,
              ),
              onPressed: onToggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

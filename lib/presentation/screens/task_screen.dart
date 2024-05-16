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
  List<Task> tasks = [];

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
                    tasks.add(Task(
                      title: title,
                      description: description.isEmpty ? null : description,
                      isCompleted: false,
                      isFavourite: false,
                      categoryId: widget.category.id,
                    ));
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

  void _deleteTask(Task task) {
    // Implement logic to delete task from data source (e.g., database)
    // Update tasks list in the UI
    setState(() {
      tasks.remove(task);
    });
  }

  void _toggleTaskCompletion(Task task) {
    // Implement logic to update task completion in data source (e.g., database)
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.blue,
      ),
      body: tasks.isNotEmpty
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(
                  task: task,
                  onDelete: () => _deleteTask(task),
                  onToggleCompletion: () => _toggleTaskCompletion(task),
                  onToggleFavorite: () {
                    setState(() {
                      task.isFavourite = !task.isFavourite;
                    });
                  },
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

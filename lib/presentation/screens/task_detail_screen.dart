// lib/presentation/screens/task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:fefu_do/domain/entities/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdate;
  final Function(Task) onDelete;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.task.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Создана: ${widget.task.createdAt}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  onPressed: () {
                    widget.task.update(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    widget.onUpdate(widget.task);
                    Navigator.pop(context);
                  },
                  child: const Text('Сохранить'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    widget.onDelete(widget.task);
                    Navigator.pop(context);
                  },
                  child: const Text('Удалить'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/services/flickr_service.dart';

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
  late FlickrService _flickrService;
  List<String> _images = [];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _flickrService = FlickrService();
    _fetchImages();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _fetchImages() async {
    final images = await _flickrService.fetchImages('nature', _page);
    setState(() {
      _images.addAll(images);
    });
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
      body: SingleChildScrollView(
        child: Column(
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
                  if (widget.task.imageUrl != null) ...[
                    Image.network(widget.task.imageUrl!),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.task.imageUrl = null;
                        });
                      },
                    ),
                  ],
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
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.task.imageUrl = _images[index];
                          });
                        },
                        child: Image.network(_images[index]),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: _fetchImages,
                    child: const Text('Загрузить ещё'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

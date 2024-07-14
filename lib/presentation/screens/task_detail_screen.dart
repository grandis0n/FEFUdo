import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fefu_do/domain/entities/task.dart';
import 'package:fefu_do/presentation/cubits/task_cubit.dart';
import 'package:fefu_do/presentation/cubits/task_state.dart';
import 'package:fefu_do/data/datasources/flickr_service.dart';
import 'package:get_it/get_it.dart';

import '../cubits/image_cubit.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController(text: task.title);
    final TextEditingController _descriptionController = TextEditingController(text: task.description);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(task.title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<TaskCubit>()),
          BlocProvider(create: (context) => ImageCubit(GetIt.I<FlickrService>())..fetchImages('nature', 1)),
        ],
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, taskState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            'Создана: ${task.createdAt}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    if (task.imageUrl != null) ...[
                      Image.network(task.imageUrl!),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TaskCubit>().modifyTask(task.copyWith(imageUrl: null));
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      ),
                      onPressed: () {
                        context.read<TaskCubit>().modifyTask(task.copyWith(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        ));
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
                        context.read<TaskCubit>().deleteTaskById(task.id);
                        Navigator.pop(context);
                      },
                      child: const Text('Удалить'),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ImageCubit, ImageState>(
                      builder: (context, imageState) {
                        if (imageState is ImageLoading) {
                          return CircularProgressIndicator();
                        } else if (imageState is ImageLoaded) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemCount: imageState.images.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<TaskCubit>().modifyTask(task.copyWith(imageUrl: imageState.images[index]));
                                },
                                child: Image.network(imageState.images[index]),
                              );
                            },
                          );
                        } else if (imageState is ImageError) {
                          return Text('Ошибка: ${imageState.message}');
                        }
                        return Container();
                      },
                    ),
                    TextButton(
                      onPressed: () => context.read<ImageCubit>().fetchImages('nature', 1),
                      child: const Text('Загрузить ещё'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

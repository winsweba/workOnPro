import 'package:main_todo/app/data/models/task.dart';
import 'package:main_todo/app/data/providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTaks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
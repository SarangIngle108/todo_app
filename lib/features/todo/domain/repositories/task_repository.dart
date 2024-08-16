import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  void addTask(Task task);
  void updateTask(Task task);
  void deleteTask(int id);
  void markTaskComplete(int id);
}

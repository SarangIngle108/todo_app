import 'package:todo_app/features/todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl({
    required this.taskRemoteDataSource,
  });

  @override
  void addTask(Task task) {
    // TODO: implement addTask
  }

  @override
  void deleteTask(int id) {
    // TODO: implement deleteTask
  }

  @override
  Future<List<Task>> getTasks() async {
    return await taskRemoteDataSource.fetchTasks();
  }

  @override
  void markTaskComplete(int id) {
    // TODO: implement markTaskComplete
  }

  @override
  void updateTask(Task task) {
    // TODO: implement updateTask
  }
}

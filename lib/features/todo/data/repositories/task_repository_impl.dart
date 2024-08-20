import 'package:get_it/get_it.dart';
import 'package:todo_app/core/local_db/object_gen.dart';
import 'package:todo_app/features/todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;
  final ObjectBox objectBox = GetIt.instance<ObjectBox>();

  TaskRepositoryImpl({
    required this.taskRemoteDataSource,
  });

  @override
  Future<List<Task>> getTasks() async {
    //If the app is opened for the first time
    //fetch few tasks from remote
    if (objectBox.getBoolean() == true) {
      return await taskRemoteDataSource.fetchTasks();
    }
    //else fetch tasks locally
    else {
      return objectBox.taskBox.getAll();
    }
  }
}

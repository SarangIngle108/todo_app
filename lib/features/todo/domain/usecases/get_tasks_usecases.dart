import '../entities/task.dart';
import '../repositories/task_repository.dart';

// class GetTasks {
//   final TaskRepository repository;

//   GetTasks(this.repository);

//   Future<List<Task>> call() async {
//     return await repository.getTasks();
//   }
// }

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    try {
      return await repository.getTasks();
    } catch (e) {
      return [];
    }
  }
}

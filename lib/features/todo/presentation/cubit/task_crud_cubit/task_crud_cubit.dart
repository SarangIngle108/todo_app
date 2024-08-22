import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/core/local_db/object_gen.dart';
import 'package:todo_app/features/todo/data/models/task_model.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/get_tasks_usecases.dart';

part 'task_crud_state.dart';

class TaskCrudCubit extends Cubit<TaskCrudState> {
  final GetTasks getTasks;
  final ObjectBox objectBox = GetIt.instance<ObjectBox>();

  TaskCrudCubit({required this.getTasks}) : super(TaskCrudInitial());

  void fetchTasks() async {
    emit(FetchTaskProgress());
    try {
      final tasks = await getTasks();

      emit(FetchTaskSucess(
          task: tasks.where((element) {
        return element.isCompleted == false;
      }).toList()));
    } catch (e) {
      emit(const FetchTaskFailed(error: 'error'));
    }
  }

  void addTask(String title) {
    emit(FetchTaskProgress());
    TaskModel createTask = TaskModel(
      id: 0,
      title: title,
      isCompleted: false,
    );
    try {
      objectBox.taskBox.put(createTask);
      final tasksfromlocal = objectBox.taskBox.getAll();

      emit(FetchTaskSucess(
          task: tasksfromlocal.where((element) {
        return element.isCompleted == false;
      }).toList()));
    } catch (e) {
      emit(const FetchTaskFailed(error: 'error'));
    }
  }

  void removeTask(Task deleteTask) {
    emit(FetchTaskProgress());

    final task = objectBox.taskBox.get(deleteTask.id);
    if (task != null) {
      task.isCompleted = true;
      objectBox.taskBox.put(task); // Save the updated task back to ObjectBox
    }

    final tasksFromLocal = objectBox.taskBox.getAll();
    emit(FetchTaskSucess(
        task: tasksFromLocal.where((element) {
      return element.isCompleted == false;
    }).toList()));
  }

  void undoTask(Task deleteTask) {
    emit(FetchTaskProgress());

    final task = objectBox.taskBox.get(deleteTask.id);
    if (task != null) {
      task.isCompleted = false;
      objectBox.taskBox.put(task); // Save the updated task back to ObjectBox
    }

    final tasksFromLocal = objectBox.taskBox.getAll();
    emit(FetchTaskCompleted(
        task: tasksFromLocal.where((element) {
      return element.isCompleted == true;
    }).toList()));
  }

  void editTask(Task editTask, String newTitle) {
    emit(FetchTaskProgress());

    final task = objectBox.taskBox.get(editTask.id);
    if (task != null) {
      task.title = newTitle;
      objectBox.taskBox.put(task); // Save the updated task back to ObjectBox
    }

    final tasksFromLocal = objectBox.taskBox.getAll();
    emit(FetchTaskSucess(
        task: tasksFromLocal.where((element) {
      return element.isCompleted == false;
    }).toList()));
  }

  void deleteTask(Task deleteTask) {
    emit(FetchTaskProgress());

    try {
      // Delete the task from ObjectBox
      objectBox.taskBox.remove(deleteTask.id);

      // Fetch the remaining tasks from the local database
      final tasksFromLocal = objectBox.taskBox.getAll();

      emit(FetchTaskCompleted(
          task: tasksFromLocal.where((element) {
        return element.isCompleted == true;
      }).toList()));
    } catch (e) {
      emit(const FetchTaskFailed(error: 'Failed to remove task.'));
    }
  }

  void fetchCompletedTask() {
    emit(FetchTaskProgress());

    try {
      final tasksfromlocal = objectBox.taskBox.getAll();

      emit(FetchTaskCompleted(
          task: tasksfromlocal.where((element) {
        return element.isCompleted == true;
      }).toList()));
    } catch (e) {
      emit(const FetchTaskFailed(error: 'w'));
    }
  }
}

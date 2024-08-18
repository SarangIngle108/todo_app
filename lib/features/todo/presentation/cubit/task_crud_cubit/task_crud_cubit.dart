import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/data/models/task_model.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/get_tasks_usecases.dart';

part 'task_crud_state.dart';

class TaskCrudCubit extends Cubit<TaskCrudState> {
  final GetTasks getTasks;

  TaskCrudCubit({required this.getTasks}) : super(TaskCrudInitial());
  List<Task> task = [];
  Future<List<Task>> fetchTasks() async {
    emit(FetchTaskProgress());

    final tasks = await getTasks();
    task = tasks;
    if (task.length > 0) {
      emit(FetchTaskSucess(task: task));
    } else {
      emit(FetchTaskFailed(error: 'w'));
    }
    return task;
  }

  void addTask(String title) {
    emit(FetchTaskProgress());
    TaskModel createTask = TaskModel(
      id: task.isNotEmpty ? task.last.id + 1 : 1,
      title: title,
      isCompleted: false,
    );
    task.add(createTask);
    print(task);
    emit(FetchTaskSucess(task: task));
  }

  void removeTask(Task deleteTask) {
    emit(FetchTaskProgress());
    deleteTask.isCompleted = true;
    task.remove(deleteTask);
    print(task);
    emit(FetchTaskSucess(task: task));
  }

  void fetchCompletedTask() {
    emit(FetchTaskProgress());

    emit(FetchTaskSucess(
        task: task.where(
      (element) {
        return element.isCompleted == true;
      },
    ).toList()));
  }
}

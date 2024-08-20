part of 'task_crud_cubit.dart';

abstract class TaskCrudState extends Equatable {
  const TaskCrudState();

  @override
  List<Object> get props => [];
}

class TaskCrudInitial extends TaskCrudState {
  @override
  List<Object> get props => [];
}

class FetchTaskProgress extends TaskCrudState {
  @override
  List<Object> get props => [];
}

class FetchTaskSucess extends TaskCrudState {
  final List<Task> task;
  const FetchTaskSucess({required this.task});

  @override
  List<Object> get props => [task];
}

class FetchTaskCompleted extends TaskCrudState {
  final List<Task> task;
  const FetchTaskCompleted({required this.task});

  @override
  List<Object> get props => [task];
}

class FetchTaskFailed extends TaskCrudState {
  final String error;
  const FetchTaskFailed({required this.error});
  @override
  List<Object> get props => [error];
}

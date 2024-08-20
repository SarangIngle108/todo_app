import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';

class TaskCompletedPage extends StatefulWidget {
  const TaskCompletedPage({super.key});

  @override
  State<TaskCompletedPage> createState() => _TaskCompletedPageState();
}

class _TaskCompletedPageState extends State<TaskCompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCrudCubit, TaskCrudState>(
        builder: (context, state) {
          if (state is FetchTaskCompleted) {
            if (state.task.isEmpty) {
              return const Center(
                child: Text('No completed tasks found.'),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final task = state.task[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          task.title,
                          maxLines: 5,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  overflow: TextOverflow.ellipsis),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.undo, color: Colors.green),
                              onPressed: () {
                                BlocProvider.of<TaskCrudCubit>(context)
                                    .undoTask(task);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                BlocProvider.of<TaskCrudCubit>(context)
                                    .deleteTask(task);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: state.task.length,
              );
            }
          } else if (state is FetchTaskProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchTaskFailed) {
            return const Center(
              child: Text('Failed to load tasks.'),
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}

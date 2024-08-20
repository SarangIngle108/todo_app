import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String taskTitle = '';
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              taskTitle = value;
            },
            decoration: const InputDecoration(hintText: 'Task Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  // Handle adding the task
                  BlocProvider.of<TaskCrudCubit>(context).addTask(taskTitle);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<TaskCrudCubit>(context).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCrudCubit, TaskCrudState>(
        builder: (context, state) {
          if (state is FetchTaskSucess) {
            if (state.task.isEmpty) {
              return const Center(
                child: Text('No  tasks found.'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final task = state.task[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 1,
                            child: ListTile(
                              leading: const Icon(
                                Icons.radio_button_unchecked,
                                color: Colors.grey,
                              ),
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
                              onTap: () {
                                // Toggle task completion status
                                BlocProvider.of<TaskCrudCubit>(context)
                                    .removeTask(task);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                          Text('Task is marked as completed'),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: state.task.length),
                ],
              ),
            );
          } else if (state is FetchTaskProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchTaskFailed) {
            return const Text('Failed to load tasks');
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

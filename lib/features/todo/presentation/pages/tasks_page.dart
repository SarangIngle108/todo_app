import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<TaskCrudCubit>(context).fetchTasks();
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Todo'),
      ),
      body: BlocBuilder<TaskCrudCubit, TaskCrudState>(
        builder: (context, state) {
          if (state is FetchTaskSucess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              state.task[index].title,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        );
                      },
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
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
            return const Text('Something went wrong');
          } else {
            return Text('bad state');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}

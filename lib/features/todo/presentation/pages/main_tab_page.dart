import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';
import 'package:todo_app/features/todo/presentation/pages/task_completed_page.dart';
import 'package:todo_app/features/todo/presentation/pages/tasks_page.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Todo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'To-Do'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskPage(),
            TaskCompletedPage(),
          ],
        ),
      ),
    );
  }
}

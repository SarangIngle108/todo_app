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

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  List<Widget> listOfPage = const [
    TaskPage(),
    TaskCompletedPage(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 1) {
          BlocProvider.of<TaskCrudCubit>(context).fetchCompletedTask();
        }
        if (_tabController.index == 0) {
          BlocProvider.of<TaskCrudCubit>(context).fetchTasks();
        }
      });
    });
  }

  //dispose the controller
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Task Todo',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'To-do',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _tabController.index,
          children: listOfPage,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:objectbox/objectbox.dart';
import 'package:todo_app/features/todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo_app/features/todo/data/repositories/task_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/task_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_tasks_usecases.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';
import 'package:todo_app/features/todo/presentation/pages/main_tab_page.dart';
import 'package:todo_app/features/todo/presentation/pages/tasks_page.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/objectbox.g.dart';

//late final Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // store = await openStore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCrudCubit(
            getTasks: GetTasks(
              TaskRepositoryImpl(
                taskRemoteDataSource: TaskRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainTabPage(),
      ),
    );
  }
}

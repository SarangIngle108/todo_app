import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/core/injects/injection_container.dart';
import 'package:todo_app/core/local_db/object_gen.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';
import 'package:todo_app/features/todo/presentation/pages/main_tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies();
  // Initialize ObjectBox
  final ObjectBox objectBox = GetIt.instance<ObjectBox>();

  //check if the app is opened for the first time
  if (objectBox.boolBox.isEmpty()) {
    objectBox.saveBoolean(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<TaskCrudCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo-App',
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

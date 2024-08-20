import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/local_db/object_gen.dart';
import 'package:todo_app/features/todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo_app/features/todo/data/repositories/task_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/task_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_tasks_usecases.dart';
import 'package:todo_app/features/todo/presentation/cubit/task_crud_cubit/task_crud_cubit.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  // Register the ObjectBox instance
  final objectBox = await ObjectBox.create();
  getIt.registerSingleton<ObjectBox>(
    objectBox,
  );

  //Register Cubit and related Dependencies
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(
      client: getIt<http.Client>(),
    ),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskRemoteDataSource: getIt<TaskRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetTasks>(
    () => GetTasks(
      getIt<TaskRepository>(),
    ),
  );

  getIt.registerFactory<TaskCrudCubit>(
    () => TaskCrudCubit(
      getTasks: getIt<GetTasks>(),
    ),
  );
}

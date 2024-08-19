import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/local_db/bject_gen.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  // Register the ObjectBox instance
  final objectBox = await ObjectBox.create();
  getIt.registerSingleton<ObjectBox>(objectBox);
}

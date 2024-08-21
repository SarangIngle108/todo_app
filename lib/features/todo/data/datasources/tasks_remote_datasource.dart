import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:todo_app/core/local_db/object_gen.dart';
import 'dart:convert';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> fetchTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final ObjectBox objectBox = GetIt.instance<ObjectBox>();
  final Client client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> fetchTasks() async {
    List<TaskModel> tasks = [];
    try {
      final response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        tasks = data
            .map((json) => TaskModel(
                  id: json['id'],
                  title: json['title'],
                  isCompleted: json['completed'],
                ))
            .toList();

        tasks.take(5).toList().forEach(
          (element) {
            try {
              TaskModel taskfromremote = TaskModel(
                id: 0,
                title: element.title,
                isCompleted: element.isCompleted,
              );
              objectBox.taskBox.put(taskfromremote);
            } catch (e) {}
          },
        );
        objectBox.saveBoolean(false);

        return tasks.take(5).toList();
      } else {
        objectBox.saveBoolean(false);

        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      objectBox.saveBoolean(false);

      throw Exception('Failed to load tasks');
    }
  }
}

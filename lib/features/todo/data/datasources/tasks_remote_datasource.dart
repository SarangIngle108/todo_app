import 'package:http/http.dart' as http;
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'dart:convert';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> fetchTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> fetchTasks() async {
    List<TaskModel> tasks = [];
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      data
          .map((json) => TaskModel(
              id: json['id'],
              title: json['title'],
              isCompleted: json['completed']))
          .take(5)
          .toList();
      tasks = data as List<TaskModel>;
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}

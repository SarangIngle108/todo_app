//import 'package:objectbox/objectbox.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id = 0,
    required super.title,
    super.isCompleted = false,
  });
}

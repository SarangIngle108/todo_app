import 'package:objectbox/objectbox.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    super.id = 0,
    required super.title,
    super.isCompleted = false,
  });
}

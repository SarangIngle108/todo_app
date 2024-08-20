import 'package:objectbox/objectbox.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

@Entity()
class TaskModel extends Task {
  @Id()
  int id;

  String title;
  bool isCompleted;

  TaskModel({
    this.id = 0, // Automatically generated if 0 or not set
    required this.title,
    this.isCompleted = false,
  }) : super(
          id: id,
          title: title,
          isCompleted: isCompleted,
        );
}

@Entity()
class BoolEntity {
  @Id()
  int id = 0; // This is required by ObjectBox and should be annotated with @Id.

  bool value;

  BoolEntity({required this.value});
}

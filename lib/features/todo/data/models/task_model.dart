//import 'package:objectbox/objectbox.dart';
// import '../../domain/entities/task.dart';

// class TaskModel extends Task {
//   TaskModel({
//     super.id = 0,
//     required super.title,
//     super.isCompleted = false,
//   });
// }

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

// import 'package:objectbox/objectbox.dart';

// @Entity()
// class TaskModel {
//   @Id(assignable: true)
//   int id;
//   String title;
//   bool isCompleted;

//   TaskModel({
//     this.id = 0, // 0 means the ID will be auto-generated by ObjectBox
//     required this.title,
//     this.isCompleted = false,
//   });
// }

// import 'package:objectbox/objectbox.dart';
// import 'package:todo_app/features/todo/domain/entities/task.dart';

// @Entity()
// class TaskModel extends Task {
//   @Id()
//   int id;

//   String title;
//   bool isCompleted;

//   TaskModel({
//     this.id = 0, // Automatically generated if 0 or not set
//     required this.title,
//     this.isCompleted = false,
//   }) : super(
//           id: id,
//           title: title,
//           isCompleted: isCompleted,
//         );
// }

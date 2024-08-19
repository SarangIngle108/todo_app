import 'package:objectbox/objectbox.dart';
import 'package:todo_app/core/local_db/object_box.dart';
import 'package:todo_app/features/todo/data/models/task_model.dart';
import 'package:todo_app/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<TaskModel> taskBox;

  ObjectBox._create(this.store) {
    taskBox = Box<TaskModel>(store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(); // Opens the ObjectBox store
    return ObjectBox._create(store);
  }
}

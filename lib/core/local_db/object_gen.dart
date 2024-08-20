import 'package:objectbox/objectbox.dart';
import 'package:todo_app/features/todo/data/models/task_model.dart';
import 'package:todo_app/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<TaskModel> taskBox;
  late final Box<BoolEntity> boolBox;

  ObjectBox._create(this.store) {
    taskBox = Box<TaskModel>(store);
    boolBox = Box<BoolEntity>(store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(); // Opens the ObjectBox store
    return ObjectBox._create(store);
  }

  void saveBoolean(bool value) {
    // Save the boolean value, assuming only one BoolEntity exists
    BoolEntity entity = BoolEntity(value: value);
    boolBox
        .removeAll(); // Remove any existing entries to ensure only one exists
    boolBox.put(entity);
  }

  bool? getBoolean() {
    return boolBox.getAll().firstOrNull?.value;
  }
}

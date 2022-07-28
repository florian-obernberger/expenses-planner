import 'package:expenses_planner/data/expenses_item.dart';
import 'package:hive_flutter/adapters.dart';

export 'package:hive_flutter/hive_flutter.dart';

enum Boxes {
  items(ExpensesItem);

  final Type boxType;
  const Boxes(this.boxType);
}

class HiveManager {
  HiveManager._();

  static Future<void> openBox<T>(Boxes box) async {
    assert(box.boxType == T);
    await Hive.openBox<T>(box.name);
  }

  static Box<T> getBox<T>(Boxes box) {
    assert(box.boxType == T);
    return Hive.box<T>(box.name);
  }

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpensesItemAdapter());

    await HiveManager.openBox<ExpensesItem>(Boxes.items);
  }
}

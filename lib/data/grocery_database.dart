import 'package:hive_flutter/hive_flutter.dart';

class GroceryDataBase {
  List groceries = [];
  final _myBox = Hive.box('myBox');

  void createInitialata() {
    groceries = [];
  }

  void loadData() {
    groceries = _myBox.get("GROCERIES");
  }

  void updateData() {
    _myBox.put("GROCERIES", groceries);
  }
}

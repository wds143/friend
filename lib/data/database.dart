import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference hive box
  final _myBox = Hive.box('mybox');

  // this method runs on first time opening the app
  void createInitialData() {
    toDoList = [
      ["Make Bed", false],
      ["Water Plants", false],
    ];
  }

  // load data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

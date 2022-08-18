import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:todo_provider/models/todo_model.dart';

late Database _db;

openDB() async {
  _db = await openDatabase(
    'todo_provider.db',
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE Todo(id TEXT, desc TEXT, isCompleted BOOLEAN)");
    },
  );
  getActiveTodos();
}

Future<List<Todo>> getActiveTodos() async {
  List<Todo> todoList = [];
  final values = await _db.rawQuery('SELECT * FROM Todo');

  //convert map to Todo object, and add to TodoList
  for (final value in values) {
    todoList.add(
      Todo.fromMap(value),
    );
  }
  log(todoList.toString());
  return todoList;
}

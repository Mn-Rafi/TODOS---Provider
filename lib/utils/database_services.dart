import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:todo_provider/models/todo_model.dart';

late Database _db;
List<Todo> allTodos = [];
openDB() async {
  _db = await openDatabase(
    'todo_provider.db',
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE Todo(id TEXT, desc TEXT, isCompleted BOOLEAN)");
    },
  );
  getTodos();
}

Future<List<Todo>> getTodos() async {
  List<Todo> todoList = [];
  final values = await _db.rawQuery('SELECT * FROM Todo');

  //convert map to Todo object, and add to TodoList
  for (final value in values) {
    todoList.add(
      Todo.fromMap(value),
    );
  }
  allTodos = todoList;
  log(todoList.toString());
  return todoList;
}

addToCart(Todo todo) async {
  await _db.rawInsert('INSERT INTO Todo(id, desc, isCompleted) VALUES(?, ?, ?)',
      [todo.id, todo.desc, todo.isCompleted == true ? 1 : 0]);
}

removeFromTodos(String id) async {
  await _db.rawDelete('DELETE FROM Todo WHERE id = ?', [id]);
  log('deleted');
}

update(Todo todo) async {
  var dbClient = await _db;
  await dbClient.rawUpdate(
      'UPDATE Todo SET isCompleted = ?, desc = ? WHERE id = ?',
      [todo.isCompleted, todo.desc, todo.id]);
}

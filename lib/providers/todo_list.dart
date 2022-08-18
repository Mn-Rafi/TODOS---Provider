import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/utils/database_services.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });
  factory TodoListState.initial() => TodoListState(todos: allTodos);
  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;
  void addTodo(String todoDesc) async {
    final newTodo = Todo(desc: todoDesc);
    // final newTodos = List.from(_state.todos)..add(newTodo);
    await addToCart(newTodo);
    final newTodos = [..._state.todos, newTodo];
    _state = _state.copyWith(todos: newTodos);
    // _state = _state.copyWith(
    // todos: List.from(_state.todos)..add(Todo(desc: todoDesc)));
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) async {
    Todo? updatingTodo;
    final List<Todo> newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        updatingTodo = Todo(
          desc: todoDesc,
          id: id,
          isCompleted: todo.isCompleted,
        );
        return Todo(
          desc: todoDesc,
          id: id,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    await update(updatingTodo!);
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) async {
    Todo? updatingTodo;
    final List<Todo> newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        updatingTodo = Todo(
          desc: todo.desc,
          id: id,
          isCompleted: !todo.isCompleted,
        );
        return Todo(
          desc: todo.desc,
          id: id,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    await update(updatingTodo!);
    _state = _state.copyWith(todos: newTodos);
    print(_state);
    notifyListeners();
  }

  void removeTodo(Todo todo) async {
    final List<Todo> newTodos =
        _state.todos.where((element) => element.id != todo.id).toList();
    _state = _state.copyWith(todos: newTodos);
    await removeFromTodos(todo.id);
    notifyListeners();
  }
}

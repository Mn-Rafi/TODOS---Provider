import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_provider/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });
  factory TodoListState.initial() => TodoListState(todos: [
        Todo(
          id: '1',
          desc: 'Buy milk',
        ),
        Todo(
          id: '2',
          desc: 'Buy eggs',
        ),
        Todo(
          id: '3',
          desc: 'Buy bread',
        ),
      ]);
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
  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    // final newTodos = List.from(_state.todos)..add(newTodo);
    final newTodos = [..._state.todos, newTodo];
    _state = _state.copyWith(todos: newTodos);
    // _state = _state.copyWith(
    //     todos: List.from(_state.todos)..add(Todo(desc: todoDesc)));
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) {
    final List<Todo> newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          desc: todoDesc,
          id: id,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final List<Todo> newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          desc: todo.desc,
          id: id,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final List<Todo> newTodos =
        _state.todos.where((element) => element.id != todo.id).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}

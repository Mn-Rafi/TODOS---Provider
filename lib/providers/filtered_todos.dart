import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilteredTodosState({
    required this.filteredTodos,
  });
  factory FilteredTodosState.initial() => FilteredTodosState(filteredTodos: []);
  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilterTodos with ChangeNotifier {
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;
  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> _filteredTodos;
    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos = todoList.state.todos
            .where((element) => !element.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoList.state.todos
            .where((element) => element.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }
    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((element) => element.desc
              .toLowerCase()
              .contains(todoSearch.state.searchTerm.toLowerCase()))
          .toList();
    }
    _state = _state.copyWith(filteredTodos: _filteredTodos);
    notifyListeners();
  }
}

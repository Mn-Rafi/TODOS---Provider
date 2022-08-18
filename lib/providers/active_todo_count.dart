import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  ActiveTodoCountState({
    required this.activeTodoCount,
  });
  factory ActiveTodoCountState.initial() =>
      ActiveTodoCountState(activeTodoCount: 0);
  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount with ChangeNotifier {
  final int initialActiveTodoCount;
  late ActiveTodoCountState _state;
  ActiveTodoCount({
    required this.initialActiveTodoCount,
  }) {
    _state = ActiveTodoCountState(activeTodoCount: initialActiveTodoCount);
  }
  // ActiveTodoCountState _state = ActiveTodoCountState.initial();
  ActiveTodoCountState get state => _state;
  void update(TodoList todoList) {
    print(todoList.state);
    final int newActiveTodoCount = todoList.state.todos
        .where((element) => !element.isCompleted)
        .toList()
        .length;
    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    print(state);
    notifyListeners();
  }
}

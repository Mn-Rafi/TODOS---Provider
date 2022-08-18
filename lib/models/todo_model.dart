import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Todo extends Equatable {
  final String id;
  final String desc;
  final bool isCompleted;
  Todo({
    String? id,
    required this.desc,
    this.isCompleted = false,
  }) : id = id ?? uuid.v4();
  static Todo fromMap(Map<String, Object?> mapFromDB) {
    final String id = mapFromDB['id'] as String;
    final String desc = mapFromDB['desc'] as String;
    final bool isCompleted = mapFromDB['isCompleted'] as bool;
    return Todo(
      id: id,
      desc: desc,
      isCompleted: isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        desc,
        isCompleted,
      ];
  bool get stringify => true;
  @override
  String toString() => 'Todo(id: $id, desc: $desc, isCompleted: $isCompleted)';
}

enum Filter {
  all,
  active,
  completed,
}

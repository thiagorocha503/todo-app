import 'package:todo/todo_overview/model/filter/todo_criteria.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoListingCriteria extends TodoCriteria {
  final int? id;

  TodoListingCriteria({required this.id});

  @override
  bool matches(Todo todo) {
    return todo.listId == id;
  }

  @override
  List<Object?> get props => [id];
}

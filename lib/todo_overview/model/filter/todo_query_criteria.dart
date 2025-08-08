import 'package:todo/todo_overview/model/filter/todo_criteria.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoQueryCriteria extends TodoCriteria {
  final String query;

  TodoQueryCriteria({required this.query});

  @override
  bool matches(Todo todo) {
    RegExp regExp = RegExp(
      "( ||\\w+)$query( ||\\w+)",
      multiLine: true,
      caseSensitive: false,
    );
    return regExp.hasMatch(todo.name);
  }

  @override
  List<Object?> get props => [query];
}

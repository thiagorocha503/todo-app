import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_overview/model/filter/todo_criteria.dart';
import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoDueDateCriteria extends TodoCriteria {}

class TodoDueDateEquals extends TodoDueDateCriteria {
  final DateTime dueDate;

  TodoDueDateEquals({required this.dueDate});

  @override
  List<Object?> get props => [dueDate.toIso8601String()];

  @override
  bool matches(Todo todo) {
    DateTime? aux = todo.dueDate;
    if (aux == null) {
      return false;
    }
    return aux.compareDateTo(dueDate) == 0;
  }
}

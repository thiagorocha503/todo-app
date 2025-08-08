import 'package:todo/todo_overview/model/filter/todo_criteria.dart';
import 'package:todo/todo_overview/model/todo.dart';

enum TodosStatus { all, activeOnly, completedOnly }

class TodoStatusCriteria extends TodoCriteria {
  final TodosStatus status;

  TodoStatusCriteria({required this.status});

  @override
  bool matches(Todo todo) {
    switch (status) {
      case TodosStatus.all:
        return true;
      case TodosStatus.activeOnly:
        return todo.completedAt == null;
      case TodosStatus.completedOnly:
        return todo.completedAt != null;
    }
  }

  @override
  List<Object?> get props => [status];
}

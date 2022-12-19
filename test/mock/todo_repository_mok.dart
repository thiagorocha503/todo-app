import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

class MockTodoRepository extends ITodoRepository {
  late List<Todo> todos;

  MockTodoRepository({required List<Todo> todos}) {
    this.todos = List.from(todos);
  }

  @override
  void delete(int id) {
    int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos.removeAt(index);
    }
  }

  @override
  Future<List<Todo>> fetch({Filter filter = Filter.all}) async {
    return todos.where((todo) {
      switch (filter) {
        case Filter.all:
          return true;
        case Filter.done:
          return todo.completeDate != null;
        case Filter.active:
          return todo.completeDate == null;
      }
    }).toList();
  }

  @override
  void insert(Todo todo) {
    todos.add(todo);
  }

  @override
  void update(Todo todo) {
    int index = todos.indexWhere((e) => e.id == todo.id);
    if (index != -1) {
      todos.removeAt(index);
      todos.insert(index, todo);
    }
  }
}

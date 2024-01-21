import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoAPI {
  Future<void> save(Todo todo);
  Future<void> delete(List<int> ids);
  Stream<List<Todo>> getTodos();
}

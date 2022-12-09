import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class ITodoProvider {
  void insert(Todo todo);
  void update(Todo todo);
  void delete(int id);
  Future<List<Todo>> fetch({required Filter filter});
}

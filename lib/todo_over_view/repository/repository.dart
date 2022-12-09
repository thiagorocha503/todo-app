import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class ITodoRepository {
  void insert(Todo todo);
  void delete(int id);
  void update(Todo todo);
  Future<List<Todo>> fetch({required Filter filter});
}

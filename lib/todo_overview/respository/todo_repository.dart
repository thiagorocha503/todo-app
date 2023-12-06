import 'package:todo/todo_overview/data/todo_database.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoRepository {
  final TodoLocalDatabase _db;
  Stream<List<Todo>> getTodos() => _db.getTodos();

  List<Todo> getCurrentTodos() => _db.getValue();
  TodoRepository(this._db);

  List<Todo> value() => _db.getValue();

  Future<void> delete(List<int> ids) async {
    return _db.delete(ids);
  }

  Future<void> save(Todo todo) async {
    return _db.save(todo);
  }
}

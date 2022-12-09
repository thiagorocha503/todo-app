import 'dart:io';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/data/database.dart';
import 'package:todo/todo_over_view/provider/provider.dart';
import 'package:todo/todo_over_view/provider/todo_provider.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

class TodoRepository implements ITodoRepository {
  late ITodoProvider _provider;
  TodoRepository() {
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows ||
        Platform.isMacOS) {
      _provider = TodoDBProvider(appDataBase: DBProvider.getTodoDB());
    } else {
      throw Exception("Platform not suported");
    }
  }

  @override
  void delete(int id) {
    _provider.delete(id);
  }

  @override
  Future<List<Todo>> fetch({required Filter filter}) async {
    return await _provider.fetch(filter: filter);
  }

  @override
  void insert(Todo todo) {
    _provider.insert(todo);
  }

  @override
  void update(Todo todo) async {
    _provider.update(todo);
  }
}

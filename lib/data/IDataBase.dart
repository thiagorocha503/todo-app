import 'package:lista_de_tarefas/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class IDBProvider {
  static IDBProvider getDBProvider() {
    return null;
  }

  Future<Database> getDataBase() async {
    return null;
  }

  Future<int> insertTodo(Todo nota) async {
    return null;
  }

  Future<int> updateTodo(Todo nota) async {
    return null;
  }

  Future<List<Todo>> fetchAll() async {
    return null;
  }

  Future<Todo> getById(int id) {
    return null;
  }

  Future<List<Todo>> findByTitle(String title) async {
    return null;
  }

  Future<List<Todo>> findByTitleAndDone(String title, bool done) async {
    return null;
  }

  Future<int> delete(int id) async {
    return null;
  }

  Future<int> markTodo(int id, bool done) async {
    return null;
  }
}

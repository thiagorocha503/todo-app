import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/database/database.dart';
import 'package:todo/todo_overview/data/interface.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoLocalDatabase implements TodoAPI {
  final DatabaseService service;

  final _taksStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  @override
  Stream<List<Todo>> getTodos() => _taksStreamController.stream;
  List<Todo> getValue() => _taksStreamController.value;

  TodoLocalDatabase(this.service) {
    _refresh();
  }

  @override
  Future<void> save(Todo todo) async {
    Database db = await service.getDataBase();
    if (todo.id == null) {
      await db.rawInsert(
          "INSERT INTO task(name, description, due_date, list_id)VALUES(?,?,?,?)",
          [
            todo.name,
            todo.description,
            todo.dueDate?.toIso8601String(),
            todo.listId,
          ]);
    } else {
      await db
          .update("task", todo.toJson(), where: "id = ?", whereArgs: [todo.id]);
    }
    _refresh();
  }

  @override
  Future<void> delete(List<int> ids) async {
    Database db = await service.getDataBase();
    await db.delete(
      "task",
      where: "id in ${ids.map((e) => '?')}",
      whereArgs: ids.map((e) => e).toList(),
    );
    _refresh();
  }

  Future<void> _refresh() async {
    Database db = await service.getDataBase();
    List<Map<String, Object?>> result = await db.query(
      "task",
    );
    List<Todo> todos = result.isNotEmpty
        ? result.map((value) => Todo.fromJson(value)).toList()
        : [];
    _taksStreamController.add(todos);
  }
}

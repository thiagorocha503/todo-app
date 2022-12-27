// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/database/database.dart';
import 'package:todo/todo_over_view/provider/provider.dart';

class TodoDBProvider implements ITodoProvider {
  final DBProvider appDataBase;
  static const TABLE_TODO_NAME = "todo";

  TodoDBProvider({required this.appDataBase});

  @override
  Future<int> insert(Todo todo) async {
    Database db = await appDataBase.getDataBase();
    return db.rawInsert(
      """INSERT INTO $TABLE_TODO_NAME(title, complete_at, note)
          VALUES(?,?,?)
      """,
      [
        todo.name,
        todo.completeDate?.toIso8601String().replaceAll("T", " "),
        todo.note
      ],
    );
  }

  @override
  Future<int> update(Todo todo) async {
    Database db = await appDataBase.getDataBase();
    return await db.rawUpdate(
      "UPDATE $TABLE_TODO_NAME set title=?, note=?, due=?, complete_at=? WHERE id=?",
      [
        todo.name,
        todo.note,
        todo.dueDate?.toIso8601String().replaceAll("T", " "),
        todo.completeDate?.toIso8601String().replaceAll("T", " "),
        todo.id
      ],
    );
  }

  @override
  Future<int> delete(int id) async {
    Database db = await appDataBase.getDataBase();
    return await db.delete(TABLE_TODO_NAME, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<List<Todo>> fetch({required Filter filter}) async {
    Database db = await appDataBase.getDataBase();
    String? where;
    switch (filter) {
      case Filter.all:
        break;
      case Filter.done:
        where = "complete_at IS NOT NULL";
        break;
      case Filter.active:
        where = "complete_at IS NULL";
        break;
    }
    var dados = await db.query(
      TABLE_TODO_NAME,
      orderBy: "created_at DESC",
      where: where,
    );
    List<Todo> todos = dados.isNotEmpty
        ? dados.map((value) => Todo.fromJson(value)).toList()
        : [];
    return todos;
  }
}

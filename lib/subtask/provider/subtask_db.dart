import 'package:sqflite/sqlite_api.dart';
import 'package:todo/data/database.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/provider/provider.dart';

class SubtaskDBProvider extends ISubtaskProvider {
  final DBProvider dbProvider;
  // ignore: constant_identifier_names
  static const TABLE_NAME = "subtask";

  SubtaskDBProvider({required this.dbProvider});
  @override
  Future<List<Subtask>> fetch({int? todoId}) async {
    Database db = await dbProvider.getDataBase();
    List<Map<String, Object?>> dados;
    if (todoId != null) {
      dados = await db.query(
        TABLE_NAME,
        where: "todo_id = ?",
        whereArgs: [todoId],
        orderBy: 'id DESC',
      );
    } else {
      dados = await db.query(
        TABLE_NAME,
        orderBy: 'id DESC',
      );
    }
    List<Subtask> subtasks = dados.isNotEmpty
        ? dados.map((value) => Subtask.fromJson(value)).toList()
        : [];
    return subtasks;
  }

  @override
  Future<int> insert(Subtask subtask) async {
    Database db = await dbProvider.getDataBase();
    return await db.rawInsert("""
      INSERT INTO $TABLE_NAME(
        name,
        complete,
        todo_id
      )
      VALUES(?,?,?)
    
     """, [
      subtask.name,
      subtask.complete ? 1 : 0,
      subtask.todoId,
    ]);
  }

  @override
  Future<int> delete(int id) async {
    Database db = await dbProvider.getDataBase();
    return await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<int> update(Subtask subtask) async {
    Database db = await dbProvider.getDataBase();
    return await db.rawUpdate(
      "UPDATE $TABLE_NAME set name = ?, complete = ? WHERE id = ?",
      [
        subtask.name,
        subtask.complete ? 1 : 0,
        subtask.id,
      ],
    );
  }
}

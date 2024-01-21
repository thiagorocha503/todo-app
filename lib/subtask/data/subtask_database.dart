import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/database/database.dart';
import 'package:todo/subtask/data/interface.dart';
import 'package:todo/subtask/model/subtask.dart';

class SubtaskLocalDatabase extends ISubtaskAPI {
  final DatabaseService service;

  final _subtaskStreamController =
      BehaviorSubject<List<Subtask>>.seeded(const []);
  @override
  Stream<List<Subtask>> getSubtasks() => _subtaskStreamController.stream;

  SubtaskLocalDatabase(this.service) {
    fetch();
  }
  @override
  Future<void> fetch() async {
    Database db = await service.getDataBase();
    List<Map<String, Object?>> dados = await db.query(
      "subtask",
      orderBy: 'id DESC',
    );

    List<Subtask> subtasks = dados.isNotEmpty
        ? dados.map((value) => Subtask.fromJson(value)).toList()
        : [];
    _subtaskStreamController.add(subtasks);
  }

  @override
  Future<void> save(Subtask subtask) async {
    Database db = await service.getDataBase();
    if (subtask.id == null) {
      await db.rawInsert("""
      INSERT INTO subtask(
        name,
        complete,
        task_id
      )
      VALUES(?,?,?)   
     """, [
        subtask.name,
        subtask.complete ? 1 : 0,
        subtask.todoId,
      ]);
    } else {
      await db.rawUpdate(
        "UPDATE subtask set name = ?, complete = ? WHERE id = ?",
        [
          subtask.name,
          subtask.complete ? 1 : 0,
          subtask.id,
        ],
      );
    }
    fetch();
  }

  @override
  Future<void> delete(int id) async {
    Database db = await service.getDataBase();
    await db.delete(
      "subtask",
      where: "id = ?",
      whereArgs: [id],
    );
    fetch();
  }
}

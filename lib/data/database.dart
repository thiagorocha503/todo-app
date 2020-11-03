import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefas/data/IDataBase.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider implements IDBProvider {
  static DBProvider _dbProvider;
  static Database _database;
  static const TABLE_TODO_NAME = "todo";

  DBProvider._(); // construtor privado

  static IDBProvider getDBProvider() {
    if (_dbProvider == null) {
      return DBProvider._();
    }
    return _dbProvider;
  }

  Future<Database> getDataBase() async {
    debugPrint("get dataBase");
    if (_database != null) {
      return _database;
    }
    _database = await _initDataBase();
    return _database;
  }

  Future<Database> _initDataBase() async {
    debugPrint("database init");
    String sql = "CREATE TABLE IF NOT EXISTS $TABLE_TODO_NAME(" +
        "id            INTEGER CONSTRAINT PK_id PRIMARY KEY AUTOINCREMENT ," +
        "title         TEXT    NOT NULL ," +
        "description   TEXT    DEFAULT ''," +
        "created_date  DATE ," +
        "due_date      DATE NOT NULL," +
        "complete_date DATE," +
        "priority      INTEGER CHECK(priority >= 1 OR priority <= 3) NOT NULL DEFAULT 2," +
        "done          BOOLEAN DEFAULT (0)" +
        "                NOT NULL" +
        "                CONSTRAINT check_is_done CHECK (done == 0 OR done == 1) );";
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dataBase.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute(sql);
      },
    );
  }

  @override
  Future<int> insertTodo(Todo nota) async {
    Database database = await this.getDataBase();
    int row = await database.insert(TABLE_TODO_NAME, nota.toJson());
    return row;
  }

  @override
  Future<int> updateTodo(Todo nota) async {
    Database dataBase = await this.getDataBase();
    return await dataBase.update(TABLE_TODO_NAME, nota.toJson(),
        where: "id=?", whereArgs: [nota.getId()]);
  }

  @override
  Future<List<Todo>> fetchAll() async {
    Database database = await this.getDataBase();
    var dados = await database.query(TABLE_TODO_NAME, orderBy: 'done');
    List<Todo> todos = dados.isNotEmpty
        ? dados.map((value) => Todo.fromJson(value)).toList()
        : [];
    return todos;
  }

  @override
  Future<List<Todo>> findByTitle(String title) async {
    Database db = await this.getDataBase();
    var result = await db
        .query(TABLE_TODO_NAME, where: "title LIKE ?", whereArgs: ['%$title%']);
    List<Todo> todos =
        (result.isNotEmpty) ? result.map((c) => Todo.fromJson(c)).toList() : [];
    return todos;
  }

  @override
  Future<List<Todo>> findByTitleAndDone(String title, bool done) async {
    Database db = await this.getDataBase();
    var result = await db.query(
      TABLE_TODO_NAME,
      where: "title LIKE ? and done = ?",
      whereArgs: ['%$title%', done ? 1 : 0],
    );
    List<Todo> todos =
        (result.isNotEmpty) ? result.map((c) => Todo.fromJson(c)).toList() : [];
    return todos;
  }

  @override
  Future<int> delete(int id) async {
    Database db = await this.getDataBase();
    return await db.delete(TABLE_TODO_NAME, where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<int> markTodo(int id, bool done) async {
    Database db = await this.getDataBase();
    return await db.rawUpdate("UPDATE $TABLE_TODO_NAME set done=? WHERE id=?",
        [((done) ? 1 : 0), id]);
  }

  @override
  Future<Todo> getById(int id) async {
    Database db = await this.getDataBase();
    List<Map<dynamic, dynamic>> result =
        await db.query(TABLE_TODO_NAME, where: "id = ?", whereArgs: [id]);
    Todo todo = (result.isNotEmpty) ? Todo.fromJson(result[0]) : null;
    return todo;
  }
}

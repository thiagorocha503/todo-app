import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefas/data/IDataBase.dart';
import 'package:lista_de_tarefas/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider implements IDBProvider{
  static DBProvider _dbProvider;
  static Database _database;

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
    String sql = "CREATE TABLE IF NOT EXISTS note(" +
        "id           INTEGER CONSTRAINT PK_id PRIMARY KEY AUTOINCREMENT ," +
        "title        TEXT    NOT NULL," +
        "description  TEXT    DEFAULT ''," +
        "date_start  DATE    NOT NULL" +
        "                CONSTRAINT check_data_start CHECK (DATE(date_start, '+0 days') IS date_start)," +
        "date_end DATE  CONSTRAINT check_data_end CHECK (DATE(date_end, '+0 days')" +
        "                   IS date_end AND  (DATE(date_end) >= DATE(date_start) ) ) " +
        "                  NOT NULL," +
        "priority INTEGER CHECK(priority >= 1 OR priority <= 3) NOT NULL DEFAULT 2," +
        "done      BOOLEAN DEFAULT (0)" +
        "         NOT NULL" +
        "         CONSTRAINT check_is_done CHECK (done == 0 OR done == 1) );";
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
  Future<int> insertNote(Note nota) async {
    Database database = await this.getDataBase();
    int row = await database.insert("note", nota.toMap());
    return row;
  }
  
  @override
  Future<int> updateNote(Note nota) async {
    Database dataBase = await this.getDataBase();
    return await dataBase
        .update("note", nota.toMap(), where: "id=?", whereArgs: [nota.getId()]);
  }

  @override
  Future<List<Note>> fetchAll() async {
    Database database = await this.getDataBase();
    var dados = await database.query("note", orderBy: 'done');
    List<Note> notes = dados.isNotEmpty
        ? dados.map((value) => Note.fromMap(value)).toList()
        : [];
    return notes;
  }

  @override
  Future<List<Note>> findByTitle(String title) async {
    Database db = await this.getDataBase();
    var result = await db.query("note", where: "title LIKE ?",whereArgs: ['%$title%']);
    List<Note> notes =
        (result.isNotEmpty) ? result.map((c) => Note.fromMap(c)).toList() : [];
    return notes;
  }
   
  @override
  Future<List<Note>> findByTitleAndDone(String title, bool done) async {
    Database db = await this.getDataBase();
    var result = await db.query("note", where: "title LIKE ? and done = ?",whereArgs: ['%$title%', done?1:0]);
    List<Note> notes =
        (result.isNotEmpty) ? result.map((c) => Note.fromMap(c)).toList() : [];
    return notes;
  }

  @override
  Future<int> delete(int id) async {
    Database db = await this.getDataBase();
    return await db.delete("note", where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<int> markNote(int id, bool done) async {
    Database db = await this.getDataBase();
    return await db
        .rawUpdate("UPDATE note set done=? WHERE id=?", [((done) ? 1 : 0), id]);
  }

  @override
  Future<Note> getById(int id) async {
    Database db = await this.getDataBase();
    List<Map<dynamic, dynamic>> result = await db.query("note", where: "id = ?",whereArgs: [id]);
    Note note =(result.isNotEmpty) ? Note.fromMap(result[0]): null;
    return note;
  }
}

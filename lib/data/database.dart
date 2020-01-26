import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefa/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static DBProvider _dbProvider;
  static Database _database;

  DBProvider._(); // construtor privado

  static DBProvider getDBProvider() {
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
    _database =  await _initDataBase();
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
  
  Future<int> insertNote(Note nota) async {
    Database database = await this.getDataBase();
    int row = await database.insert("note", nota.toMap());
    return row;
  }
  
  Future<int> updateNote(Note nota) async {
    Database dataBase = await this.getDataBase();
    return await dataBase.update("note", nota.toMap(), where: "id=?",whereArgs: [nota.getId()]);
  }

  Future<List<Note>> fetchAll() async {
    Database database = await this.getDataBase();
    var dados = await database.query("note");
    List<Note> notes = dados.isNotEmpty
        ? dados.map((value) => Note.fromMap(value)).toList()
        : [];
    return notes;
  }

    Future<int> delete(int id) async {
      Database db = await this.getDataBase();
      return await db.delete("note",where: "id = ?",whereArgs: [id]);
    }

    Future<int> markNote(int id, bool done) async {
       Database db = await this.getDataBase();
       return await db.rawUpdate("UPDATE note set done=? WHERE id=?",[((done)?1:0), id ]);
    }
}

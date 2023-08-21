import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/constants/database.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/database/schema.dart';

/// Database para platorm Mobile ou Desktop
class DBProvider {
  static DBProvider? _db;
  DBProvider._();

  final int version = 3;

  static DBProvider getTodoDB() {
    DBProvider? db = _db;
    db ??= _db = DBProvider._();
    return db;
  }

  static Database? _database;

  Future<Database> getDataBase() async {
    debugPrint("> Get dataBase");
    Database? db = _database;
    if (db == null) {
      _database = db = await _initDataBase();
      return db;
    }
    return db;
  }

  Future<Database> _initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // old version
    File file = File(join(documentsDirectory.path, "dataBase.db"));
    if (await file.exists()) {
      await file.copy(join(documentsDirectory.path, "$DATABASE_NAME.db"));
      file.delete();
    }

    String path = join(documentsDirectory.path, "$DATABASE_NAME.db");
    // Mobile
    if (Platform.isAndroid || Platform.isIOS) {
      return await openDatabase(
        path,
        version: version,
        onOpen: onOpen,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onConfigure: onConfigure,
      );
    } else if (Platform.isFuchsia) {
      throw Exception("Platform Fuchsia not suported");
    } // Desktop
    else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      return await databaseFactoryFfi.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: version,
          onOpen: onOpen,
          onCreate: onCreate,
          onUpgrade: onUpgrade,
          onConfigure: onConfigure,
        ),
      );
    } else {
      throw Exception("Invalid platorm");
    }
  }

  void onOpen(db) {
    debugPrint("DB> onOpen");
  }

  void onConfigure(Database db) {
    debugPrint("DB> onConfigure");
    db.execute("PRAGMA foreign_keys = 1");
  }

  void dumpData(Database db) async {
    List<String> schema = [];

    for (int i = 0; i < 10; i++) {
      String title = "Todo ${i + 1}";
      if (i % 2 == 0) {
        String date = DateTime.now().toIso8601String().replaceAll("T", " ");
        schema.add(
            "INSERT INTO todo(title, complete_at, note) values('$title','$date', '');");
      } else {
        schema.add("INSERT INTO todo(title, note) values('$title','');");
        //
      }
    }
    for (String sql in schema) {
      await db.execute(sql);
    }
  }

  void onCreate(Database db, int version) async {
    debugPrint("DB> onCreate");
    const List<String> schema = [
      todoSchemav2,
      subtaskSchemaV1,
    ];

    for (String sql in schema) {
      await db.execute(sql);
    }
    if (kDebugMode) {
      dumpData(db);
    }
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint("DB> onUpgrade");
    List<String> scheme = [];
    if (oldVersion == 1) {
      scheme.add(todoSchemav2); // new todo scheme
      scheme.add(
        """ 
        INSERT INTO todo(title, note, due, complete_at)
        SELECT 
          title,
          description,
          date_end,
          CASE done
            WHEN 1 THEN
              datetime('now', 'localtime')
            ELSE
              NULL
          END as complete_at
        from 
          note;
      """,
      ); // migrate data
      scheme.add("DROP table note;"); // drop old table
    }
    if (oldVersion <= 2) {
      scheme.add(subtaskSchemaV1);
    }
    for (String sql in scheme) {
      await db.execute(sql);
    }
  }
}

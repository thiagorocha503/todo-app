import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/constants/database.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/data/migration.dart';

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
    debugPrint("> onOpen");
  }

  void onConfigure(Database db) {
    debugPrint("> onConfigure");
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
    debugPrint("> onCreate");
    const List<String> schema = [
      todo_scheme_v2,
    ];

    for (String sql in schema) {
      await db.execute(sql);
    }
    if (kDebugMode) {
      dumpData(db);
    }
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint("> onUpgrade");
    if (oldVersion == 1) {
      updateToV2(db);
      updateToV3(db);
    }
    if (oldVersion == 2) {
      updateToV3(db);
    }
  }
}

void updateToV2(Database db) async {
  for (String sql in upgrade_002) {
    await db.execute(sql);
  }
}

void updateToV3(Database db) async {
  for (String sql in upgrade_003) {
    await db.execute(sql);
  }
}

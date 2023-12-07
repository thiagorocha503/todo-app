import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/constants.dart';
import 'package:todo/database/migration.dart';

/// Database para platorm Mobile ou Desktop
class DatabaseService {
  static DatabaseService? _instance;
  DatabaseService._();

  final int version = 1;

  static DatabaseService getInstance() {
    DatabaseService? db = _instance;
    db ??= _instance = DatabaseService._();
    return db;
  }

  static Database? _database;

  Future<Database> getDataBase() async {
    Database? db = _database;
    if (db == null) {
      _database = db = await _initDataBase();
      return db;
    }
    return db;
  }

  Future<Database> _initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$dataBaseName.db");
    // Mobile
    if (Platform.isAndroid || Platform.isIOS) {
      return await openDatabase(
        path,
        version: version,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDowngrade,
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
          onCreate: onCreate,
          onUpgrade: onUpgrade,
          onDowngrade: onDowngrade,
          onConfigure: onConfigure,
        ),
      );
    } else {
      throw Exception("Invalid platorm");
    }
  }

  void onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void onOpen(Database db) async {
    debugPrint("on open");
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (int version = oldVersion; version < newVersion; version++) {
      debugPrint("upgrade ${version + 1}");
      await _up(db, version + 1);
    }
  }

  void onDowngrade(Database db, int oldVersion, int newVersion) async {
    for (int version = oldVersion; version > newVersion; version--) {
      debugPrint("downgrade ${version - 1}");
      await _down(db, version - 1);
    }
  }

  void onCreate(Database db, int newVersion) async {
    for (int version = 0; version < newVersion; version++) {
      debugPrint("oncreate ${version + 1}");
      await _up(db, version + 1);
    }
  }

  Future<void> _up(Database db, int version) async {
    switch (version) {
      case 1:
        await MigrationInitial().up(db);
        break;
    }
  }

  Future<void> _down(Database db, int version) async {
    switch (version) {
      case 1:
        MigrationInitial().down(db);
        break;
    }
  }
}

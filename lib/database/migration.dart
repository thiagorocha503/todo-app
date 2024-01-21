import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class Migration {
  Future<void> down(Database db);
  Future<void> up(Database db);
}

class MigrationInitial extends Migration {
  @override
  Future<void> up(Database db) async {
    await db.execute("PRAGMA foreign_keys = off");
    // table: list
    await db.execute(""" 
    CREATE TABLE list (
          id         INTEGER PRIMARY KEY AUTOINCREMENT
                            CONSTRAINT list_id_not_null NOT NULL,
          name       TEXT    CONSTRAINT list_nome_not_null NOT NULL,
          created_at TEXT    CONSTRAINT list_created_at_default DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now') ) ) 
                            CONSTRAINT list_created_at_not_null NOT NULL,
          updated_at TEXT    CONSTRAINT list_updated_at_not_null NOT NULL
                            CONSTRAINT list_updated_at_default DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now') ) ) 
      );
      """);
    // table: task
    await db.execute("""
      CREATE TABLE task (
          id           INTEGER  CONSTRAINT pk_todo PRIMARY KEY AUTOINCREMENT
                                CONSTRAINT task_pk_not_null NOT NULL,
          name         STRING   CONSTRAINT task_name_not_null NOT NULL,
          description  STRING   CONSTRAINT task_description_default DEFAULT ('') 
                                CONSTRAINT todo_description_not_null NOT NULL,
          due_date     DATETIME,
          list_id      INTEGER  CONSTRAINT task_list_id_fk REFERENCES list (id) ON DELETE CASCADE,
          completed_at DATETIME,
          updated_at   TEXT     CONSTRAINT task_updated_at_not_null NOT NULL
                                CONSTRAINT task_updated_at_default DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now') ) ),
          created_at   DATETIME CONSTRAINT task_created_at_not_null NOT NULL
                                CONSTRAINT task_created_at_not_null_constraint DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now') ) ) 
      );

      """);
    // table: subtask
    await db.execute("""
      CREATE TABLE IF NOT EXISTS subtask (
        id       INTEGER PRIMARY KEY AUTOINCREMENT
                        CONSTRAINT subtask_pk_not_null NOT NULL,
        name     TEXT    CONSTRAINT subtask_name_not_null NOT NULL
                        CONSTRAINT subtasK_name_check CHECK (name != ''),
        complete BOOLEAN CONSTRAINT subtask_complete_not_null NOT NULL
                        CONSTRAINT subtask_complete_default DEFAULT (0) 
                        CONSTRAINT subtask_complete_check CHECK (complete = 0 OR 
                                                                  complete = 1),
        task_id  INTEGER CONSTRAINT fk_constraint REFERENCES task (id) ON DELETE CASCADE
                        CONSTRAINT subtask_task_id_not_null NOT NULL
    );
      """);

    // Trigger: update_list
    await db.execute(
        "CREATE TABLE IF NOT EXISTS task (id INTEGER CONSTRAINT pk_todo PRIMARY KEY AUTOINCREMENT CONSTRAINT task_pk_not_null NOT NULL, name STRING CONSTRAINT task_name_not_null NOT NULL, description STRING CONSTRAINT task_description_default DEFAULT ('') CONSTRAINT todo_description_not_null NOT NULL, due_date DATETIME, completed_at DATETIME, list_id INTEGER CONSTRAINT task_list_id_fk REFERENCES list (id) ON DELETE CASCADE, created_at DATETIME CONSTRAINT task_created_at_not_null NOT NULL CONSTRAINT task_created_at_not_null_constraint DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now'))), updated_at TEXT CONSTRAINT task_updated_at_not_null NOT NULL CONSTRAINT task_updated_at_default DEFAULT (STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now'))))");
    // Trigger: update_task
    await db.execute(
        "CREATE TRIGGER IF NOT EXISTS update_list AFTER UPDATE ON list BEGIN UPDATE list SET updated_at = STRFTIME('%Y-%m-%dT%H:%M:%SZ', datetime('now') ) WHERE id = NEW.id AND OLD.name != NEW.name; END");
    await db.execute("PRAGMA foreign_keys = ON");
  }

  @override
  Future<void> down(Database db) async {}
}

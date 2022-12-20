const String todoSchemav2 = """     
      CREATE TABLE  todo (
          id            INTEGER  CONSTRAINT pk_todo PRIMARY KEY AUTOINCREMENT
                        NOT NULL,
          title         STRING CONSTRAINT title_not_null_todo_constraint NOT NULL,
          note          STRING CONSTRAINT note_not_null DEFAULT '',
          due           DATETIME,
          created_at    DATETIME NOT NULL
                           CONSTRAINT created_at_not_null_constraint DEFAULT (datetime('now', 'localtime') ),
          complete_at   DATETIME
      );
      
""";
const subtaskSchemaV1 = '''
CREATE TABLE subtask (
    id       INTEGER PRIMARY KEY AUTOINCREMENT
                     NOT NULL,
    name     TEXT    CONSTRAINT name_not_null_constraint NOT NULL
                     CONSTRAINT name_check_constraint CHECK (name != ''),
    complete BOOLEAN CONSTRAINT complete_not_null_constraint NOT NULL
                     CONSTRAINT complete_default_constraint DEFAULT (0) 
                     CONSTRAINT complete_check_constraint CHECK (complete = 0 OR 
                                                                 complete = 1),
    todo_id  INTEGER CONSTRAINT fk_constraint REFERENCES todo (id) ON DELETE CASCADE
                     CONSTRAINT fk_not_null NOT NULL
);
''';

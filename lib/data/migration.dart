// ignore: constant_identifier_names
const String todo_scheme_v2 = """     
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

List<String> upgrade_002 = const [
  todo_scheme_v2,
  """
  INSERT INTO todo(
    title,
    note,
    due, 
    complete_at
  )
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
  "DROP table note;"
];

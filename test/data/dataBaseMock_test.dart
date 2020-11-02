import 'package:lista_de_tarefas/data/mock/dataBaseMock.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:test/test.dart';

void main() {
  DateTime now = DateTime.now();
  Todo nota1 = new Todo();
  nota1.setTitle("title 1");
  nota1.setDescription("Text text");
  nota1.setDateStart(now);
  nota1.setDateEnd(DateTime(now.year, now.month, now.day + 5));
  nota1.setPriority(0);
  nota1.setDone(false);

  Todo nota2 = new Todo();
  nota2.setTitle("title 2");
  nota2.setDescription("Text text");
  nota2.setDateStart(now);
  nota2.setDateEnd(DateTime(now.year, now.month, now.day + 5));
  nota2.setPriority(0);
  nota2.setDone(false);

  test("Test Insert e fetchall", () async {
    DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
    expect(1, await dataBase.insertTodo(nota1));
    expect(2, await dataBase.insertTodo(nota2));

    List<Todo> result = await dataBase.fetchAll();
    expect(result[0].getId(), nota1.getId());
    expect(result[1].getId(), nota2.getId());

    expect(result[0].getTitle(), nota1.getTitle());
    expect(result[1].getTitle(), nota2.getTitle());
  });

  test("Test getById", () async {
    DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
    dataBase.insertTodo(nota1);
    Todo result = await dataBase.getById(1);
    // verifica valores
    expect(nota1.getId(), result.getId());
    expect(nota1.getTitle(), result.getTitle());
    expect(nota1.getDescription(), result.getDescription());
    expect(nota1.getDateStart(), result.getDateStart());
    expect(nota1.getDateEnd(), result.getDateEnd());
    expect(nota1.getPriority(), result.getPriority());
    expect(nota1.getDone(), result.getDone());
  });

  test("Test remoção", () async {
    DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
    DateTime now = DateTime.now();
    Todo nota = new Todo();
    nota.setTitle("title 1");
    nota.setDescription("Text text");
    nota.setDateStart(now);
    nota.setDateEnd(DateTime(now.year, now.month, now.day + 5));
    nota.setPriority(0);
    nota.setDone(false);
    expect(1, await dataBase.insertTodo(nota));
    expect(1, await dataBase.delete(1));
    expect([], dataBase.getTodo());
  });

  test("Test update", () async {
    DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
    // adiciona tarefa
    expect(1, await dataBase.insertTodo(nota1));
    // objeto com as atualizações
    Todo todoNew = new Todo();
    todoNew.setId(1);
    todoNew.setTitle("title 2");
    todoNew.setDescription("Text text");
    todoNew.setDateStart(now);
    todoNew.setDateEnd(DateTime(now.year, now.month, now.day + 8));
    todoNew.setPriority(1);
    todoNew.setDone(true);
    // atualiza valores
    expect(1, await dataBase.updateTodo(todoNew));

    //verifica valores
    Todo result = await dataBase.getById(1);
    expect(todoNew.getId(), result.getId());
    expect(todoNew.getTitle(), result.getTitle());
    expect(todoNew.getDescription(), result.getDescription());
    expect(todoNew.getDateStart(), result.getDateStart());
    expect(todoNew.getDateEnd(), result.getDateEnd());
    expect(todoNew.getPriority(), result.getPriority());
    expect(todoNew.getDone(), result.getDone());
  });
}

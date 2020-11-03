import 'package:lista_de_tarefas/data/mock/dataBaseMock.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:test/test.dart';

void main() {
  group("Datebase test", () {
    DateTime now = DateTime.now();
    Todo nota1 = new Todo();
    nota1.title = "title 1";
    nota1.description = "Text text";
    nota1.createdDate = DateTime(now.year, now.month, now.day + 5);
    nota1.dueDate = DateTime(now.year, now.month, now.day + 5);
    nota1.priority = 0;
    nota1.done = false;

    Todo nota2 = new Todo();
    nota2.title = "title 2";
    nota2.description = "Text text";
    nota2.createdDate = now;
    nota2.dueDate = DateTime(now.year, now.month, now.day + 5);
    nota2.priority = 0;
    nota2.done = false;

    test("Test Insert and fetchall", () async {
      DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
      expect(1, await dataBase.insertTodo(nota1));
      expect(2, await dataBase.insertTodo(nota2));

      List<Todo> result = await dataBase.fetchAll();
      //expect(t, matcher)
      expect(result[0].getId(), nota1.getId());
      expect(result[1].getId(), nota2.getId());

      expect(result[0].title, nota1.title);
      expect(result[1].description, nota2.description);
    });

    test("Test getById", () async {
      DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
      dataBase.insertTodo(nota1);
      Todo result = await dataBase.getById(1);
      // verifica valores
      expect(nota1.getId(), result.getId());
      expect(nota1.getTitle(), result.getTitle());
      expect(nota1.getDescription(), result.getDescription());
      expect(nota1.createdDate, result.createdDate);
      expect(nota1.dueDate, result.dueDate);
      expect(nota1.getPriority(), result.getPriority());
      expect(nota1.getDone(), result.getDone());
    });

    test("Test delete", () async {
      DBProviderMockImpl dataBase = DBProviderMockImpl.getDBProvider();
      DateTime now = DateTime.now();
      Todo nota = new Todo();
      nota.setTitle("title 1");
      nota.setDescription("Text text");
      nota.createdDate = now;
      nota.dueDate = DateTime(now.year, now.month, now.day + 5);
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
      todoNew.createdDate = now;
      todoNew.dueDate = DateTime(now.year, now.month, now.day + 8);
      todoNew.setPriority(1);
      todoNew.setDone(true);
      // atualiza valores
      expect(1, await dataBase.updateTodo(todoNew));

      //verifica valores
      Todo result = await dataBase.getById(1);
      expect(todoNew.getId(), result.getId());
      expect(todoNew.getTitle(), result.getTitle());
      expect(todoNew.getDescription(), result.getDescription());
      expect(todoNew.createdDate, result.createdDate);
      expect(todoNew.dueDate, result.dueDate);
      expect(todoNew.getPriority(), result.getPriority());
      expect(todoNew.getDone(), result.getDone());
    });
  });
}

import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/todo.dart';

class ISearchPresenter {
  Future<List<Map>> findByTitle(String title) {
    throw NullThrownError();
  }
}

class SearchPresenter implements ISearchPresenter {
  Future<List<Map>> findByTitle(String title) async {
    DBProvider db = DBProvider.getDBProvider();
    var result = await db.findByTitle(title);
    List<Map> todos = List<Map>();
    for (Todo todo in result) {
      Map json = {
        "id": todo.id,
        "title": todo.title,
        "description": todo.description,
        "created_date": todo.createdDate == null
            ? null
            : "${todo.createdDate.year.toString().padLeft(4, '0')}-${todo.createdDate.month.toString().padLeft(2, '0')}-${todo.createdDate.day.toString().padLeft(2, '0')}",
        "due_date":
            "${todo.dueDate.year.toString().padLeft(4, '0')}-${todo.dueDate.month.toString().padLeft(2, '0')}-${todo.dueDate.day.toString().padLeft(2, '0')}",
        "complete_date": todo.completeDate == null
            ? null
            : "${todo.completeDate.year.toString().padLeft(4, '0')}-${todo.completeDate.month.toString().padLeft(2, '0')}-${todo.completeDate.day.toString().padLeft(2, '0')}",
        "priority": todo.priority,
        "done": todo.done,
      };
      todos.add(json);
    }
    //debugPrint(list.toString());
    return todos;
  }
}

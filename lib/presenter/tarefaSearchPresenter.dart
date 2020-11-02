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
      Map todoMap = {
        "id": todo.id,
        "title": todo.title,
        "description": todo.description,
        "dateStart":
            "${todo.dateStart.year.toString().padLeft(4, '0')}-${todo.dateStart.month.toString().padLeft(2, '0')}-${todo.dateStart.day.toString().padLeft(2, '0')}",
        "dateEnd":
            "${todo.dateEnd.year.toString().padLeft(4, '0')}-${todo.dateEnd.month.toString().padLeft(2, '0')}-${todo.dateEnd.day.toString().padLeft(2, '0')}",
        "priority": todo.priority,
        "done": todo.done
      };
      todos.add(todoMap);
    }
    //debugPrint(list.toString());
    return todos;
  }
}

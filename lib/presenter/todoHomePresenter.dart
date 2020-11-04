import 'dart:async';

import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class HomePresent implements IHomePresenter {
  IHomePage view;
  // ignore: close_sinks
  StreamController _controller =
      StreamController<List<Map<dynamic, dynamic>>>();

  @override
  Stream<List<Map<dynamic, dynamic>>> get stream => _controller.stream;

  HomePresent(this.view);

  @override
  Future<void> fetchAll(int filter) async {
    await _fetchAll(filter);
  }

  Future<void> _fetchAll(int filter) async {
    DBProvider db = DBProvider.getDBProvider();
    List<Todo> data;
    try {
      if (filter == 1) {
        data = await db.findByTitleAndDone("", false);
      } else if (filter == 2) {
        data = await db.findByTitleAndDone("", true);
      } else if (filter == 3) {
        data = await db.fetchAll();
      } else {
        throw new Exception("Invalid filter: $filter");
      }
      List<Map<dynamic, dynamic>> todos = List<Map>();
      for (Todo todo in data) {
        Map todoMap = {
          "id": todo.id,
          "title": todo.title,
          "description": todo.description,
          "created_date":
              "${todo.createdDate.year.toString().padLeft(4, '0')}-${todo.createdDate.month.toString().padLeft(2, '0')}-${todo.createdDate.day.toString().padLeft(2, '0')}",
          "due_date":
              "${todo.dueDate.year.toString().padLeft(4, '0')}-${todo.dueDate.month.toString().padLeft(2, '0')}-${todo.dueDate.day.toString().padLeft(2, '0')}",
          "complete_date": todo.completeDate == null
              ? null
              : "${todo.completeDate.year.toString().padLeft(4, '0')}-${todo.completeDate.month.toString().padLeft(2, '0')}-${todo.completeDate.day.toString().padLeft(2, '0')}",
          "priority": todo.priority,
          "done": todo.done,
        };
        todos.add(todoMap);
      }
      this._controller.sink.add(todos);
    } on Exception catch (ex) {
      this._controller.sink.addError(ex);
    }
  }

  @override
  void deleteTodo(int id) async {
    DBProvider db = DBProvider.getDBProvider();
    int result = await db.delete(id);
    if (result > 0) {
      this.view.showSnackBarInfo("Tarefa removida com sucesso");
      this.view.onRefresh();
    } else {
      this.view.showSnackBarInfo("Erro ao remove tarefa");
    }
  }

  @override
  Future<int> markTodo(int id, bool value) async {
    DBProvider db = DBProvider.getDBProvider();
    return await db.markTodo(id, value);
  }

  @override
  void close() {
    this._controller.close();
  }

  @override
  void about() {
    this.view.showAboutPage();
  }
}

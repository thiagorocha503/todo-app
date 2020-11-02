import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class NoteEditPresenter implements ITodoEditPresenter {
  ITodoEdit view;

  Future<void> updateTodo(Map dados) async {
    Todo todo = new Todo();
    todo.setId(dados["id"]);
    todo.setTitle(dados["title"]);
    todo.setDescription(dados["description"]);
    todo.setDateStart(dados["dateStart"]);
    todo.setDateEnd(dados["dateEnd"]);
    todo.setPriority(dados["priority"]);
    todo.setDone(dados["done"]);
    DBProvider db = DBProvider.getDBProvider();
    int res = await db.updateTodo(todo);
    debugPrint("update -> $res");
    if (res > 0) {
      this.view.showSnackBarMessage("Tarefa atualizada com sucesso!");
    } else {
      this.view.showSnackBarMessage("erro!");
    }
  }

  void setView(ITodoEdit view) {
    this.view = view;
  }

  @override
  Future<void> delete(int id) async {
    DBProvider db = DBProvider.getDBProvider();
    int res = await db.delete(id);
    debugPrint("delete: -> $res");
    if (res > 0) {
      this.view.backPage();
    } else {
      this.view.showSnackBarMessage("erro! $res");
    }
  }

  @override
  Future<List> getTodoById(int id) async {
    return null;
  }
}

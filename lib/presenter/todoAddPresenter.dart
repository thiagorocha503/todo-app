//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class TarefaAddPresenter implements ITodoAddPresenter {
  IPageNewTodo view;

  @override
  Future todoInsert(Map dados) async {
    Todo todo = new Todo();
    todo.setTitle(dados["title"]);
    todo.setDescription(dados["description"]);
    todo.setDateCreated(dados["created_date"]);
    todo.dueDate = dados["due_date"];
    if (dados["done"] == true) {
      todo.completeDate = dados["complete_date"];
    }
    todo.setPriority(dados["priority"]);
    todo.setDone(dados["done"]);
    DBProvider db = DBProvider.getDBProvider();
    db.insertTodo(todo).then((onValue) {
      debugPrint(">>> $onValue");
      if (onValue > 0) {
        this.view.showSnackBarMessage("Tarefa salva");
        this.view.cleanField();
      } else {
        this.view.showSnackBarMessage("Erro");
      }
    });
  }

  @override
  void setView(IPageNewTodo view) {
    this.view = view;
  }
}

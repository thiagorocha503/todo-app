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
    todo.setDateStart(dados["dateStart"]);
    todo.setDateEnd(dados["dateEnd"]);
    todo.setPriority(dados["priority"]);
    todo.setDone(dados["done"]);
    DBProvider db = DBProvider.getDBProvider();
    db.insertTodo(todo).then((onValue) {
      debugPrint(">>> $onValue");
      if (onValue > 0) {
        this.view.showSnackBarMessage("Tarefa salva com sucesso");
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

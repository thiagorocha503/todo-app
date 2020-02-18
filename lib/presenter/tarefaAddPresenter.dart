//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefa/data/database.dart';
import 'package:lista_de_tarefa/model/note.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/util/dateConversion.dart';
import 'package:lista_de_tarefa/view/view.dart';

class TarefaAddPresenter implements IPresenterTarefaAdd {
  IPageNewNote view;

  @override
  Future noteInsert(Map dados) async {
    Note nota = new Note();
    nota.setTitle(dados["title"]);
    nota.setDescription(dados["description"]);
    nota.setDateStart(DateConversion.dateFormtToDateTime(dados["dateStart"]));
    nota.setDateEnd(DateConversion.dateFormtToDateTime(dados["dateEnd"]));
    nota.setPriority(dados["priority"]);
    nota.setDone(dados["done"]);
    DBProvider db = DBProvider.getDBProvider();
    db.insertNote(nota).then((onValue) {
      debugPrint(">>> $onValue");
      if (onValue > 0) {
        this.view.showSnackBarMessage("sucesso");
      } else {
        this.view.showSnackBarMessage("Erro");
      }
    });
  }

  @override
  void setView(IPageNewNote view) {
    this.view = view;
  }
}

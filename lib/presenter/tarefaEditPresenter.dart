

import 'package:flutter/cupertino.dart';
import 'package:lista_de_tarefa/data/database.dart';
import 'package:lista_de_tarefa/model/note.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/util/DateConversion.dart';
import 'package:lista_de_tarefa/view/view.dart';

class NoteEditPresenter implements IEditPresenter{
  INoteEdit view;
  
  Future<void> updateNote(Map dados) async {
    Note note = new Note();
    note.setId(dados["id"]);
    note.setTitle(dados["title"]);
    note.setDescription(dados["description"]);
    note.setDateStart(DateConversion.dateFormtToDateTime(dados["dateStart"]));
    note.setDateEnd(DateConversion.dateFormtToDateTime(dados["dateEnd"]));
    note.setPriority(dados["priority"]);
    note.setDone(dados["done"]);
    DBProvider db = DBProvider.getDBProvider();
    int res = await db.updateNote(note);
    debugPrint("update -> $res");
    if(res>0){
      this.view.showSnackBarMessage("atualizado com sucesso!");
    } else {
      this.view.showSnackBarMessage("erro!");
    }
  }

   void setView(INoteEdit view){
    this.view = view;
   }

  @override
  Future<void> delete(int id) async {
    DBProvider db = DBProvider.getDBProvider();
    int res = await db.delete(id);
    debugPrint("delete: -> $res");
    if(res>0){
      this.view.backPage();
    } else {
      this.view.showSnackBarMessage("erro! $res");
    }
  }

  @override
  Future<List> getNoteById(int id) async {
    return null;
  }
}
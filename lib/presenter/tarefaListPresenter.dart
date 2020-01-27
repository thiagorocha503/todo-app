

import 'package:lista_de_tarefa/data/database.dart';
import 'package:lista_de_tarefa/model/note.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/view/view.dart';

class TarefaListPresent implements IPresenterNoteList {
  IPageList view;

  @override
  Future<int> deleteNote(int id) async {
    DBProvider db = DBProvider.getDBProvider();
    return await db.delete(id);
  }

  @override
  Future<List<Map<dynamic, dynamic>>> fetchAll() async {
     DBProvider db = DBProvider.getDBProvider();
     List<Note> dados = await db.fetchAll();
     List<Map> notes = List<Map>();
     for(Note note in dados){
       Map noteMap = {
       "id": note.id,
        "title": note.title,
        "description": note.description,
        "dateStart": "${note.dateStart.day.toString().padLeft(2, '0')}/${note.dateStart.month.toString().padLeft(2, '0')}/${note.dateStart.year.toString().padLeft(4, '0')}",
        "dateEnd": "${note.dateEnd.day.toString().padLeft(2, '0')}/${note.dateEnd.month.toString().padLeft(2, '0')}/${note.dateEnd.year.toString().padLeft(4, '0')}",
        "priority": note.priority,
        "done": note.done};
       notes.add(noteMap);
     }
     return  notes;
  }

  @override
  Future<List<Map>> findNoteByTitle(String title) {
    return null;
  }

  @override
  Future<int> markNote(int id, bool value) async {
    DBProvider db = DBProvider.getDBProvider();
    return await db.markNote(id, value);
  }

  @override
  void setView(IPageList view) {
    this.view = view;
  }

  @override
  Future<List<Map>> updateList() async {
   return await this.fetchAll();
  }



}
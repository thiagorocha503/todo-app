import 'package:lista_de_tarefa/view/view.dart';

class IPresenterNoteList {
  Future<int> markNote(int id, bool value) async {return null;}
  void deleteNote(int id) async {}
  Future<List<Map>> fetchAll() async {return new List<Map>();}
  Future<List<Map>> findNoteByTitle(String title) async {return new List<Map>();}
  void setView(IPageList view) {}
  Future<List<Map>> updateList() async {return List<Map>(); }}


class IPresenterTarefaAdd{

  Future  noteInsert(Map note){return null;}
  void setView(IPageNewNote view){}

}

class IEditPresenter{
  void updateNote(Map note){}
  void delete(int id){return null;}
  void setView(INoteEdit view){}
   Future<List> getNoteById(int id){return null;}
}
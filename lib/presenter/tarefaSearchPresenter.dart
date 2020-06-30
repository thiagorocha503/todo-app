
import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/note.dart';

class ISearchPresenter{

  Future<List<Map>> findByTitle(String title){throw NullThrownError();}

}

class SearchPresenter implements ISearchPresenter{

  Future<List<Map>> findByTitle(String title) async {
    DBProvider db = DBProvider.getDBProvider();
    var result = await db.findByTitle(title);
    List<Map> list = List<Map>();
    for(Note note in result){
      Map noteMap = {
        "id": note.id,
        "title": note.title,
        "description": note.description,
        "dateStart": "${note.dateStart.day.toString().padLeft(2, '0')}/${note.dateStart.month.toString().padLeft(2, '0')}/${note.dateStart.year.toString().padLeft(4, '0')}",
        "dateEnd": "${note.dateEnd.day.toString().padLeft(2, '0')}/${note.dateEnd.month.toString().padLeft(2, '0')}/${note.dateEnd.year.toString().padLeft(4, '0')}",
        "priority": note.priority,
        "done": note.done
      };
      list.add(noteMap);
    }
    //debugPrint(list.toString());
    return list;
  }
  
}



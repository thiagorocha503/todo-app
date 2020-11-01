import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/note.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class TarefaListPresent implements IPresenterNoteList {
  IPageList view;

  @override
  void deleteNote(int id) async {
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
  Future<List<Map<dynamic, dynamic>>> fetchAll(int filter) async {
    DBProvider db = DBProvider.getDBProvider();
    List<Note> dados;
    if (filter == 1) {
      dados = await db.findByTitleAndDone("", false);
    } else if (filter == 2) {
      dados = await db.findByTitleAndDone("", true);
    } else if (filter == 3) {
      dados = await db.fetchAll();
    }
    List<Map> notes = List<Map>();
    for (Note note in dados) {
      Map noteMap = {
        "id": note.id,
        "title": note.title,
        "description": note.description,
        "dateStart":
            "${note.dateStart.year.toString().padLeft(4, '0')}-${note.dateStart.month.toString().padLeft(2, '0')}-${note.dateStart.day.toString().padLeft(2, '0')}",
        "dateEnd":
            "${note.dateEnd.year.toString().padLeft(4, '0')}-${note.dateEnd.month.toString().padLeft(2, '0')}-${note.dateEnd.day.toString().padLeft(2, '0')}",
        "priority": note.priority,
        "done": note.done
      };
      notes.add(noteMap);
    }
    return notes;
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
  void refresh(int filter) async {
    List notes = await this.fetchAll(filter);
    this.view.updateList(notes);
  }

  @override
  void about() {
    this.view.showAboutPage();
  }
}

import 'package:lista_de_tarefas/view/view.dart';

class IHomePresenter {
  Future<int> markTodo(int id, bool value) async {
    return null;
  }

  void deleteTodo(int id) async {}
  Future<void> fetchAll(int filter) async {}
  void about() {}
  void close() {}

  Stream<List<Map<dynamic, dynamic>>> get stream => null;
}

class ITodoAddPresenter {
  Future todoInsert(Map todo) {
    return null;
  }

  void setView(IPageNewTodo view) {}
}

class ITodoEditPresenter {
  void updateTodo(Map todo) {}
  void delete(int id) {
    return null;
  }

  void setView(ITodoEdit view) {}
  Future<List> getTodoById(int id) {
    return null;
  }
}

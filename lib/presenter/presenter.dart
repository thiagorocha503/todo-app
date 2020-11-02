import 'package:lista_de_tarefas/view/view.dart';

class ITodoListPresenter {
  Future<int> markTodo(int id, bool value) async {
    return null;
  }

  void deleteTodo(int id) async {}
  Future<List<Map>> fetchAll(int filter) async {
    return new List<Map>();
  }

  void setView(IPageList view) {}
  void refresh(int filter) {}
  void about() {}
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

class IAboutPresenter {
  void setView(IAboutPage view) {}
  void share() {}
  void shop() {}
  void sendFeedBack() {}
}

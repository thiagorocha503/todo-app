import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

class TodoRepositoryMock extends ITodoRepository {
  late List<Todo> _todos;
  int contador = 4;

  TodoRepositoryMock() {
    _todos = [
      Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: null),
      Todo(
        id: 2,
        name: "quis ut nam facilis et officia qui",
        createdDate: DateTime(DateTime.now().year, 2, 1),
        completeDate: DateTime(DateTime.now().year, 3, 15),
        dueDate: null,
      ),
      Todo(
        id: 3,
        name: "quis ut nam facilis et officia qui",
        createdDate: DateTime(DateTime.now().year, 2, 1),
        dueDate: null,
      ),
    ];
  }

  @override
  void delete(int id) {
    int index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.removeAt(index);
    }
  }

  @override
  Future<List<Todo>> fetch({Filter filter = Filter.all}) async {
    return _todos.where((todo) {
      switch (filter) {
        case Filter.all:
          return true;
        case Filter.done:
          return todo.completeDate != null;
        case Filter.active:
          return todo.completeDate == null;
      }
    }).toList();
  }

  @override
  void insert(Todo todo) {
    _todos.add(todo.copyWith(
      id: contador++,
      createdDate: todo.createdDate,
      note: todo.note,
      dueDate: todo.dueDate,
      completeDate: todo.completeDate,
    ));
  }

  @override
  void update(Todo todo) {
    int index = _todos.indexWhere((e) => e.id == todo.id);
    if (index != -1) {
      _todos.removeAt(index);
      _todos.insert(index, todo);
    }
  }
}

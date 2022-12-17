import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/repository/repository.dart';

class SubtasksRepositoryMock extends ISubtaskRepository {
  late List<Subtask> subtasks;

  SubtasksRepositoryMock({required List<Subtask> subtasks}) {
    this.subtasks = List<Subtask>.from(subtasks);
  }

  @override
  void insert(Subtask subtask) {
    subtasks.add(subtask);
  }

  @override
  void delete(int id) {
    Subtask subtask = subtasks.firstWhere((subtask) => subtask.id == id);
    subtasks.remove(subtask);
  }

  @override
  Future<List<Subtask>> fetch({int todoId = 1}) async {
    return subtasks.where((subtask) => subtask.todoId == todoId).toList();
  }

  @override
  void update(Subtask subtask) {
    int index = subtasks.indexWhere((e) => e.id == subtask.id);
    if (index != -1) {
      subtasks.removeAt(index);
      subtasks.insert(index, subtask);
    }
  }
}

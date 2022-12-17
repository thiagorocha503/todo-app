import 'package:todo/subtask/model/subtask.dart';

abstract class ISubtaskProvider {
  void insert(Subtask subtask);
  void update(Subtask subtask);
  void delete(int id);
  Future<List<Subtask>> fetch({int? todoId});
}

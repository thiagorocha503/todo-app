import 'package:todo/subtask/model/subtask.dart';

abstract class ISubtaskRepository {
  void insert(Subtask subtask);
  void delete(int id);
  void update(Subtask subtask);
  Future<List<Subtask>> fetch({int todoId});
}

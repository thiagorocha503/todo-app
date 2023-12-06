import 'package:todo/subtask/model/subtask.dart';

abstract class ISubtaskAPI {
  Future<void> save(Subtask subtask);
  Future<void> delete(int id);
  Future<void> fetch();
  Stream<List<Subtask>> getSubtasks();
}

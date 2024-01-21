import 'package:todo/subtask/data/interface.dart';
import 'package:todo/subtask/model/subtask.dart';

class SubtaskRepository {
  late ISubtaskAPI db;

  Stream<List<Subtask>> getSubtasks() => db.getSubtasks();

  SubtaskRepository(this.db);

  Future<void> delete(int id) async {
    await db.delete(id);
  }

  Future<void> save(Subtask subtask) async {
    await db.save(subtask);
  }
}

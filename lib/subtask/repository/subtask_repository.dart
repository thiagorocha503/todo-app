import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:todo/database/database.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/provider/provider.dart';
import 'package:todo/subtask/provider/subtask_db.dart';
import 'package:todo/subtask/repository/repository.dart';

@GenerateNiceMocks([MockSpec<SubtaskRepository>()])
class SubtaskRepository extends ISubtaskRepository {
  late ISubtaskProvider _provider;

  SubtaskRepository() {
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows ||
        Platform.isMacOS) {
      _provider = SubtaskDBProvider(dbProvider: DBProvider.getTodoDB());
    } else {
      throw Exception("Platform not suported");
    }
  }

  @override
  void delete(int id) {
    _provider.delete(id);
  }

  @override
  Future<List<Subtask>> fetch({int? todoId}) async {
    return await _provider.fetch(todoId: todoId);
  }

  @override
  void insert(Subtask subtask) {
    _provider.insert(subtask);
  }

  @override
  void update(Subtask subtask) {
    _provider.update(subtask);
  }
}

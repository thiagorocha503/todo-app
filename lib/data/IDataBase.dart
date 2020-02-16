import 'package:lista_de_tarefa/model/note.dart';
import 'package:sqflite/sqflite.dart';

class IDBProvider {
  static IDBProvider getDBProvider() {return null;}
  Future<Database> getDataBase() async {return null;}
  Future<int> insertNote(Note nota) async {return null;}
  Future<int> updateNote(Note nota) async {return null;}
  Future<List<Note>> fetchAll() async {return null;}
  Future<Note> getById(int id){return null;}
  Future<List<Note>> findByTitle(String title) async {return null;}
  Future<List<Note>> findByTitleAndDone(String title, bool done) async {return null;}
  Future<int> delete(int id) async {return null;}
  Future<int> markNote(int id, bool done) async {return null;}
}

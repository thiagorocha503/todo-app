


import 'package:lista_de_tarefas/data/IDataBase.dart';
import 'package:lista_de_tarefas/data/database.dart';
import 'package:lista_de_tarefas/model/note.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProviderMockImpl implements IDBProvider{
  
  List<Note> todo =[];
  int id = 1;
  static DBProvider _dbProvider;
  DBProviderMockImpl._();

  static IDBProvider getDBProvider() {
    if(_dbProvider == null){
      return DBProviderMockImpl._();
    }
    return _dbProvider;
  }
  
  @override
  Future<int> delete(int id)async {
    for(int i=0; i<this.todo.length;i++){
      if(this.todo[i].getId() == id){
       this.todo.removeAt(i);
        return 1;
      }
    }
    return 0;
  }

  @override
  Future<List<Note>> fetchAll() async {
    return  this.todo;
  }

  @override
  Future<List<Note>> findByTitle(String title) async{
    // 
    return null;
  }

  @override
  Future<List<Note>> findByTitleAndDone(String title, bool done) async{
    //
    return null;
  }

  @override
  Future<Database> getDataBase() async{
    return null;
  }

  @override
  Future<int> insertNote(Note nota) async {
    nota.setId(id);
    this.todo.add(nota);   
    int oldId = id;
    id += 1;
    return oldId;
  }

  @override
  Future<int> markNote(int id, bool done)async {
    for(int i=0; i<this.todo.length;i++){
      if(this.todo[i].getId() == id){
        this.todo[i].setDone(done);
        return 1;
      }
    }
    return 0;
  }

  @override
  Future<int> updateNote(Note nota) async{
   for(int i=0; i<this.todo.length;i++){
      if(this.todo[i].getId() == nota.getId()){
        this.todo[i] = nota;
        return 1;
      }
    }
    return 0;
  }
  
  List getTodo(){
    return this.todo;
  }

  @override
  Future<Note> getById(int id) async{
    for(int i=0; i<this.todo.length;i++){
      if(this.todo[i].getId() == id){
        return this.todo[i];
      }
    }
    return null;
  }
}
import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/database/database.dart';
import 'package:todo/list_overview/data/interface.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/todo_overview/data/todo_database.dart';

class ListingLocalDatabase implements IListingAPI {
  final DatabaseService _service;
  final _listingStreamController = BehaviorSubject<List<Listing>>.seeded(
    const [],
  );
  final TodoLocalDatabase _todoDB;

  @override
  Stream<List<Listing>> getListing() => _listingStreamController.stream;

  List<Listing> getValue() => _listingStreamController.value;
  ListingLocalDatabase(DatabaseService service, TodoLocalDatabase db)
      : _service = service,
        _todoDB = db {
    _refresh();
    _todoDB.getTodos().listen((event) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
    Database db = await _service.getDataBase();
    List<Map<String, Object?>> data = await db.rawQuery(
      """
        select *, 
          (select
            count(*) 
           from 
            task 
          where
            list_id=list.id and completed_at is null
          ) 
          as count
        from 
          list
        order by 
          name ASC
        """,
    );
    List<Listing> listing = data.isNotEmpty
        ? data.map((value) => Listing.fromMap(value)).toList()
        : [];
    _listingStreamController.add(listing);
  }

  @override
  Future<void> save(Listing list) async {
    Database db = await _service.getDataBase();
    if (list.id == null) {
      await db.rawInsert("INSERT INTO list(name) values(?)", [list.name]);
    } else {
      await db.rawUpdate("""
      UPDATE 
        list 
      SET 
        name=?, updated_at=datetime('now')
      WHERE id=?""", [list.name, list.id]);
    }
    _refresh();
  }

  @override
  Future<void> delete(int id) async {
    Database db = await _service.getDataBase();
    await db.delete("list", where: "id=? ", whereArgs: [id]);
    _refresh();
  }
}

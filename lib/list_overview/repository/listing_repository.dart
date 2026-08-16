import 'package:todo/list_overview/data/listing_database.dart';
import 'package:todo/list_overview/model/listing.dart';

class ListingRepository {
  final ListingLocalDatabase _db;

  Stream<List<Listing>> getListing() => _db.getListing();

  List<Listing> getCurrentListing() => _db.getValue();

  ListingRepository(this._db);

  Future<void> saveListing(Listing list) async {
    await _db.save(list);
  }

  Future<void> delete(int id) async {
    await _db.delete(id);
  }
}

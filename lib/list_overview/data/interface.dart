import 'package:todo/list_overview/model/listing.dart';

abstract class IListingAPI {
  Stream<List<Listing>> getListing();
  Future<void> save(Listing list);
  Future<void> delete(int id);
}

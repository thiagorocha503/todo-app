import 'package:equatable/equatable.dart';
import 'package:todo/list_overview/model/listing.dart';

abstract class ListingOverviewBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListingOverviewListSubscriptionRequested
    extends ListingOverviewBlocEvent {
  ListingOverviewListSubscriptionRequested();
}

class ListingOverviewListingSaved extends ListingOverviewBlocEvent {
  final Listing listing;
  ListingOverviewListingSaved({required this.listing});
  @override
  List<Object?> get props => [listing];
}

class ListingOverviewListingDeleted extends ListingOverviewBlocEvent {
  final int id;

  ListingOverviewListingDeleted({required this.id});
  @override
  List<Object?> get props => [id];
}

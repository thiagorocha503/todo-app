import 'package:equatable/equatable.dart';
import 'package:todo/list_overview/model/listing.dart';

abstract class ListingOverviewState extends Equatable {
  final List<Listing> list;

  const ListingOverviewState({required this.list});
  @override
  List<Object?> get props => [list];
}

class ListingOverviewInitialState extends ListingOverviewState {
  const ListingOverviewInitialState({required super.list});
}

class ListingOverviewLoadingState extends ListingOverviewState {
  const ListingOverviewLoadingState({required super.list});
}

class ListingOverviewLoadedState extends ListingOverviewState {
  const ListingOverviewLoadedState({required super.list});
}

class ListingOverviewErrorState extends ListingOverviewState {
  final Exception error;

  const ListingOverviewErrorState({required super.list, required this.error});
  @override
  List<Object?> get props => [super.list, error.toString()];
}

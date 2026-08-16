import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/repository/listing_repository.dart';
import 'package:todo/todo_overview/repository/todo_repository.dart';

class ListingOverviewBloc
    extends Bloc<ListingOverviewBlocEvent, ListingOverviewState> {
  final ListingRepository _listRepository;
  ListingOverviewBloc(super.initialState,
      {required ListingRepository listRepository,
      required TodoRepository todoRepository})
      : _listRepository = listRepository {
    on<ListingOverviewListSubscriptionRequested>((event, emit) async {
      emit(ListingOverviewLoadingState(list: state.list));
      await emit.forEach(
        _listRepository.getListing(),
        onData: (data) {
          return ListingOverviewLoadedState(list: data);
        },
      );
    });
    on<ListingOverviewListingSaved>((event, emit) async {
      try {
        await _listRepository.saveListing(event.listing);
      } on Exception catch (e) {
        emit(ListingOverviewErrorState(list: state.list, error: e));
      }
    });

    on<ListingOverviewListingDeleted>((event, emit) async {
      try {
        await _listRepository.delete(event.id);
      } on Exception catch (e) {
        emit(ListingOverviewErrorState(list: state.list, error: e));
      }
    });
  }
}

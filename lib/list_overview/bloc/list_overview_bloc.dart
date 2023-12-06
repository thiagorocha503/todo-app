import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/respository/listing_repository.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';

class ListingOverviewBloc
    extends Bloc<ListingOverviewBlocEvent, ListingOverviewState> {
  final ListingRespository _listRespository;
  ListingOverviewBloc(super.initialState,
      {required ListingRespository listRepository,
      required TodoRepository todoRepository})
      : _listRespository = listRepository {
    on<ListingOverviewListSubscriptionRequested>((event, emit) async {
      emit(ListingOverviewLoadingState(list: state.list));
      await emit.forEach(
        _listRespository.getListing(),
        onData: (data) {
          return ListingOverviewLoadedState(list: data);
        },
      );
    });
    on<ListingOverviewListingSaved>((event, emit) async {
      try {
        await _listRespository.saveListing(event.listing);
      } on Exception catch (e) {
        emit(ListingOverviewErrorState(list: state.list, error: e));
      }
    });

    on<ListingOverviewListingDeleted>((event, emit) async {
      try {
        await _listRespository.delete(event.id);
      } on Exception catch (e) {
        emit(ListingOverviewErrorState(list: state.list, error: e));
      }
    });
  }
}

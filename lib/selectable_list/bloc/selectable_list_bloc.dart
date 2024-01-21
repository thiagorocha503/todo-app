import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/selectable_list/bloc/selectable_list_event.dart';
import 'package:todo/selectable_list/bloc/selectable_list_state.dart';
import 'package:todo/selectable_list/model/selectable_list.dart';

class SelectableListBloc
    extends Bloc<SelectableListEvent, SelectableListState> {
  SelectableListBloc(super.initialState) {
    on<SelectableListDeselectedAllItem>((event, emit) {
      emit(state.copyWith(
          itens: state.itens.map((e) => e.copyWith(selected: false)).toList()));
    });
    on<SelectableListSelectedAllItem>((event, emit) {
      emit(state.copyWith(
          itens: state.itens.map((e) => e.copyWith(selected: true)).toList()));
    });
    on<SelectableListUpdateItens>((event, emit) {
      emit(state.copyWith(
          itens: event.itens
              .map((e) => SelectableListItem(id: e, selected: false))
              .toList()));
    });
    on<SelectableListCanceled>((event, emit) {
      emit(
        state.copyWith(
          enabled: false,
          // reset selectins
          itens: state.itens.map((e) => e.copyWith(selected: false)).toList(),
        ),
      );
    });

    on<SelectableListTappedItem>((event, emit) {
      if (state.enabled) {
        try {
          SelectableListItem oldItem =
              state.itens.firstWhere((e) => e.id == event.id);

          SelectableListItem newItem =
              oldItem.copyWith(id: oldItem.id, selected: !oldItem.selected);
          emit(
            state.copyWith(
                itens: List.from(state.itens)
                  ..remove(oldItem)
                  ..add(newItem)),
          );
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
      }
    });
    on<SelectableListLongPressedItem>((event, emit) {
      if (!state.enabled) {
        try {
          SelectableListItem oldItem = state.itens.firstWhere((e) {
            return e.id == event.id;
          });

          emit(
            state.copyWith(
                enabled: true,
                itens: List.from(state.itens)
                  ..remove(oldItem)
                  ..add(oldItem.copyWith(selected: true))),
          );
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }
}

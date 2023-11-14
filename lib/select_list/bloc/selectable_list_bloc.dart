import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/select_list/bloc/selectable_list_event.dart';
import 'package:todo/select_list/bloc/selectable_list_state.dart';
import 'package:todo/select_list/model/selectable_list_item.dart';

class SelectableListBloc<T>
    extends Bloc<SelectableListEvent, SelectableListState<T>> {
  SelectableListBloc(super.initialState) {
    on<SelectableListDeselectedAllItem>((event, emit) {
      emit(state.copyWith(
          itens: state.itens.map((e) => e.copyWith(selected: false)).toList()));
    });
    on<SelectableListSelectedAllItem>((event, emit) {
      emit(state.copyWith(
          itens: state.itens.map((e) => e.copyWith(selected: true)).toList()));
    });
    on<SelectableListUpdateItens<T>>((event, emit) {
      emit(state.copyWith(
          itens: event.itens
              .map((e) => SelectableListItem<T>(id: e, selected: false))
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

    on<SelectableListTappedItem<T>>((event, emit) {
      if (state.enabled) {
        try {
          SelectableListItem<T> oldItem =
              state.itens.firstWhere((e) => e.id == event.id);

          SelectableListItem<T> newItem =
              oldItem.copyWith(item: oldItem.id, selected: !oldItem.selected);
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
    on<SelectableListLongPressedItem<T>>((event, emit) {
      if (!state.enabled) {
        try {
          SelectableListItem<T> oldItem = state.itens.firstWhere((e) {
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

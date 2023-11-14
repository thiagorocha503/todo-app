import 'package:equatable/equatable.dart';
import 'package:todo/select_list/model/selectable_list_item.dart';

class SelectableListState<T> extends Equatable {
  final bool enabled;
  final List<SelectableListItem<T>> itens;

  const SelectableListState({required this.enabled, required this.itens});
  @override
  List<Object?> get props => [itens, enabled];

  SelectableListState<T> copyWith({
    bool? enabled,
    List<SelectableListItem<T>>? itens,
  }) {
    return SelectableListState(
      enabled: enabled ?? this.enabled,
      itens: itens ?? this.itens,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:todo/selectable_list/model/selectable_list.dart';

class SelectableListState<T> extends Equatable {
  final bool enabled;
  final List<SelectableListItem> itens;

  const SelectableListState({required this.enabled, required this.itens});
  @override
  List<Object?> get props => [itens, enabled];

  SelectableListState<T> copyWith({
    bool? enabled,
    List<SelectableListItem>? itens,
  }) {
    return SelectableListState(
      enabled: enabled ?? this.enabled,
      itens: itens ?? this.itens,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:todo/selectable_list/model/selectable_list.dart';

class SelectableListState<T> extends Equatable {
  final bool enabled;
  final List<SelectableListItem> items;

  const SelectableListState({required this.enabled, required this.items});
  @override
  List<Object?> get props => [items, enabled];

  SelectableListState<T> copyWith({
    bool? enabled,
    List<SelectableListItem>? items,
  }) {
    return SelectableListState(
      enabled: enabled ?? this.enabled,
      items: items ?? this.items,
    );
  }
}

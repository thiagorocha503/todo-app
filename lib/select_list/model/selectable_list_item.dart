import 'package:equatable/equatable.dart';

class SelectableListItem<T> extends Equatable {
  final T id;
  final bool selected;

  const SelectableListItem({required this.id, required this.selected});

  @override
  List<Object?> get props => [id, selected];

  SelectableListItem<T> copyWith({T? item, bool? selected}) {
    return SelectableListItem<T>(
      id: item ?? this.id,
      selected: selected ?? this.selected,
    );
  }
}

import 'package:equatable/equatable.dart';

class SelectableListItem extends Equatable {
  final int id;
  final bool selected;

  const SelectableListItem({required this.id, required this.selected});

  @override
  List<Object?> get props => [id, selected];

  SelectableListItem copyWith({int? id, bool? selected}) {
    return SelectableListItem(
      id: id ?? this.id,
      selected: selected ?? this.selected,
    );
  }
}

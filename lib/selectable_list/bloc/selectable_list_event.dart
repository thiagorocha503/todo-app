import 'package:equatable/equatable.dart';

abstract class SelectableListEvent extends Equatable {}

class SelectableListTappedItem extends SelectableListEvent {
  final int id;

  SelectableListTappedItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectableListLongPressedItem extends SelectableListEvent {
  final int id;

  SelectableListLongPressedItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectableListSelectedAllItem extends SelectableListEvent {
  @override
  List<Object?> get props => [];
}

class SelectableListDeselectedAllItem extends SelectableListEvent {
  @override
  List<Object?> get props => [];
}

class SelectableListUpdateItems extends SelectableListEvent {
  final List<int> items;

  SelectableListUpdateItems({required this.items});

  @override
  List<Object?> get props => [items];
}

class SelectableListCanceled extends SelectableListEvent {
  SelectableListCanceled();
  @override
  List<Object?> get props => [];
}

class SelectableListClean extends SelectableListEvent {
  @override
  List<Object?> get props => [];
}

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

class SelectableListUpdateItens extends SelectableListEvent {
  final List<int> itens;

  SelectableListUpdateItens({required this.itens});

  @override
  List<Object?> get props => [itens];
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

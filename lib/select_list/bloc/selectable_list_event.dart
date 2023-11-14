import 'package:equatable/equatable.dart';

abstract class SelectableListEvent extends Equatable {}

class SelectableListTappedItem<T> extends SelectableListEvent {
  final T id;

  SelectableListTappedItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectableListLongPressedItem<T> extends SelectableListEvent {
  final T id;

  SelectableListLongPressedItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectableListSelectedAllItem<T> extends SelectableListEvent {
  @override
  List<Object?> get props => [];
}

class SelectableListDeselectedAllItem<T> extends SelectableListEvent {
  @override
  List<Object?> get props => [];
}

class SelectableListUpdateItens<T> extends SelectableListEvent {
  final List<T> itens;

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
  List<Object?> get props => throw UnimplementedError();
}

import 'package:equatable/equatable.dart';

abstract class TodoEditEvent extends Equatable {
  const TodoEditEvent();
}

class TodoEditTitleChanged extends TodoEditEvent {
  final String title;

  const TodoEditTitleChanged({required this.title});

  @override
  List<Object?> get props => [title];
}

class TodoEditCompleteDateChanged extends TodoEditEvent {
  final DateTime? date;

  const TodoEditCompleteDateChanged({required this.date});

  @override
  List<Object?> get props => [date];
}

class TodoEditDueDateChanged extends TodoEditEvent {
  final DateTime? dueDate;

  const TodoEditDueDateChanged({required this.dueDate});

  @override
  List<Object?> get props => [dueDate];
}

class TodoEditNoteChanged extends TodoEditEvent {
  final String note;

  const TodoEditNoteChanged({required this.note});

  @override
  List<Object?> get props => [note];
}

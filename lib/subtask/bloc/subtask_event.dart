import 'package:equatable/equatable.dart';

abstract class SubtaskEvent extends Equatable {}

class SubtaskSubscriptionRequested extends SubtaskEvent {
  @override
  List<Object?> get props => [];
}

class SubtaskAddedEvent extends SubtaskEvent {
  final String title;
  final int taskId;

  SubtaskAddedEvent({required this.title, required this.taskId});
  @override
  List<Object?> get props => [title, taskId];
}

class SubtaskDeletedEvent extends SubtaskEvent {
  final int id;

  SubtaskDeletedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SubtaskTitleChangedEvent extends SubtaskEvent {
  final int? id;
  final String title;

  SubtaskTitleChangedEvent({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}

class SubtaskCompletionToggledEvent extends SubtaskEvent {
  final int? id;
  final bool isCompleted;

  SubtaskCompletionToggledEvent({required this.id, required this.isCompleted});

  @override
  List<Object?> get props => [id, isCompleted];
}

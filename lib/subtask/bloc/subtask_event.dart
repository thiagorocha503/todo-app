import 'package:equatable/equatable.dart';
import 'package:todo/subtask/model/subtask.dart';

abstract class SubtaskEvent extends Equatable {}

class SubtaskSubscriptionRequested extends SubtaskEvent {
  @override
  List<Object?> get props => [];
}

class SubtaskSavedEvent extends SubtaskEvent {
  final Subtask subtask;

  SubtaskSavedEvent({required this.subtask});

  @override
  List<Object?> get props => [subtask];
}

class SubtaskDeletedEvent extends SubtaskEvent {
  final int id;

  SubtaskDeletedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

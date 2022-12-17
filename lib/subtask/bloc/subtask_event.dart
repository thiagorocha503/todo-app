import 'package:equatable/equatable.dart';
import 'package:todo/subtask/model/subtask.dart';

abstract class SubtaskEvent extends Equatable {}

class FetchSubtasksEvent extends SubtaskEvent {
  FetchSubtasksEvent();
  @override
  List<Object?> get props => [];
}

class AddSubtaskEvent extends SubtaskEvent {
  final Subtask subtask;

  AddSubtaskEvent({required this.subtask});

  @override
  List<Object?> get props => [subtask];
}

class UpdateSubtaskEvent extends SubtaskEvent {
  final Subtask subtask;

  UpdateSubtaskEvent({required this.subtask});

  @override
  List<Object?> get props => [subtask];
}

class DeleteSubtaskEvent extends SubtaskEvent {
  final int id;

  DeleteSubtaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

import 'package:equatable/equatable.dart';
import 'package:todo/subtask/model/subtask.dart';

abstract class SubtaskState extends Equatable {
  final List<Subtask> subtasks;
  const SubtaskState({required this.subtasks});
}

class SubtasksLoadedState extends SubtaskState {
  const SubtasksLoadedState({required super.subtasks});

  @override
  List<Object?> get props => [subtasks];
}

class SubtasksLoadingState extends SubtaskState {
  const SubtasksLoadingState({required super.subtasks});

  @override
  List<Object?> get props => [subtasks];
}

class SubtaskErrorState extends SubtaskState {
  final Exception error;

  const SubtaskErrorState({required this.error, required super.subtasks});

  @override
  List<Object?> get props => [subtasks, error];
}

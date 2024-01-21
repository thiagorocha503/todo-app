import 'package:equatable/equatable.dart';
import 'package:todo/subtask/model/subtask.dart';

abstract class SubtaskState extends Equatable {
  final List<Subtask> subtasks;
  final int taskId;
  const SubtaskState({required this.taskId, required this.subtasks});
  @override
  List<Object?> get props => [subtasks, taskId];
}

class SubtasksLoadedState extends SubtaskState {
  const SubtasksLoadedState({required super.subtasks, required super.taskId});
}

class SubtasksLoadingState extends SubtaskState {
  const SubtasksLoadingState({required super.subtasks, required super.taskId});
}

class SubtaskErrorState extends SubtaskState {
  final Exception error;

  const SubtaskErrorState(
      {required this.error, required super.subtasks, required super.taskId});

  @override
  List<Object?> get props => [super.subtasks, super.subtasks, error];
}

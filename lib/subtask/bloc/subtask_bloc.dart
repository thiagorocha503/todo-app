import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  final SubtaskRepository _repository;

  SubtaskBloc(super.initialState, {required SubtaskRepository repository})
      : _repository = repository {
    on<SubtaskSubscriptionRequested>((event, emit) async {
      emit(
          SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId));
      await emit.forEach(
        _repository.getSubtasks(),
        onData: (data) {
          return SubtasksLoadedState(
            taskId: state.taskId,
            subtasks: data.where((e) => e.todoId == state.taskId).toList(),
          );
        },
      );
    });
    on<SubtaskSavedEvent>(_mapSavedSubtask);
    on<SubtaskDeletedEvent>(_mapDeleteSubtask);
  }

  Future<void> _mapSavedSubtask(
      SubtaskSavedEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(
          SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId));
      await _repository.save(event.subtask);
    } on Exception catch (error) {
      emit(SubtaskErrorState(
          subtasks: state.subtasks, error: error, taskId: state.taskId));
    }
  }

  Future<void> _mapDeleteSubtask(
      SubtaskDeletedEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(
          SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId));
      await _repository.delete(event.id);
    } on Exception catch (error) {
      emit(SubtaskErrorState(
          subtasks: state.subtasks, error: error, taskId: state.taskId));
    }
  }
}

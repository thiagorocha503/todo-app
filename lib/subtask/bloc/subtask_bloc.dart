import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  final SubtaskRepository _repository;

  SubtaskBloc(super.initialState, {required this._repository}) {
    on<SubtaskSubscriptionRequested>((event, emit) async {
      emit(
        SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId),
      );
      await emit.forEach(
        _repository.getSubtasks(),
        onData: (data) {
          List<Subtask> tasks = data
              .where((e) => e.todoId == state.taskId)
              .toList();
          tasks.sort((a, b) {
            int? left = a.id;
            int? right = b.id;
            if (left == null || right == null) {
              return 0;
            }
            return left - right;
          });
          return SubtasksLoadedState(taskId: state.taskId, subtasks: tasks);
        },
        onError: (error, stackTrace) {
          return SubtaskErrorState(
            taskId: state.taskId,
            subtasks: state.subtasks,
            error: Exception(error),
          );
        },
      );
    });
    on<SubtaskAddedEvent>(_maAddedSubtask);
    on<SubtaskDeletedEvent>(_mapDeleteSubtask);
    on<SubtaskTitleChangedEvent>(_mapTitleChanged);
    on<SubtaskCompletionToggledEvent>(_mapCompletionToggled);
  }

  Future<void> _mapTitleChanged(
    SubtaskTitleChangedEvent event,
    Emitter<SubtaskState> emit,
  ) async {
    try {
      emit(
        SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId),
      );
      Subtask subtask = state.subtasks.firstWhere((subtask) {
        return subtask.id == event.id;
      });
      await _repository.save(subtask.copyWith(name: event.title));
    } on Exception catch (error) {
      emit(
        SubtaskErrorState(
          subtasks: state.subtasks,
          error: error,
          taskId: state.taskId,
        ),
      );
    }
  }

  Future<void> _mapCompletionToggled(
    SubtaskCompletionToggledEvent event,
    Emitter<SubtaskState> emit,
  ) async {
    try {
      emit(
        SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId),
      );
      Subtask subtask = state.subtasks.firstWhere((subtask) {
        return subtask.id == event.id;
      });
      await _repository.save(subtask.copyWith(complete: event.isCompleted));
    } on Exception catch (error) {
      emit(
        SubtaskErrorState(
          subtasks: state.subtasks,
          error: error,
          taskId: state.taskId,
        ),
      );
    }
  }

  Future<void> _maAddedSubtask(
    SubtaskAddedEvent event,
    Emitter<SubtaskState> emit,
  ) async {
    try {
      await _repository.save(
        Subtask(name: event.title, complete: false, todoId: state.taskId),
      );
    } on Exception catch (error) {
      emit(
        SubtaskErrorState(
          subtasks: state.subtasks,
          error: error,
          taskId: state.taskId,
        ),
      );
    }
  }

  Future<void> _mapDeleteSubtask(
    SubtaskDeletedEvent event,
    Emitter<SubtaskState> emit,
  ) async {
    try {
      emit(
        SubtasksLoadingState(subtasks: state.subtasks, taskId: state.taskId),
      );
      await _repository.delete(event.id);
    } on Exception catch (error) {
      emit(
        SubtaskErrorState(
          subtasks: state.subtasks,
          error: error,
          taskId: state.taskId,
        ),
      );
    }
  }
}

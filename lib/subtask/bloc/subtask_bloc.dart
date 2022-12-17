import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/repository/repository.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  final ISubtaskRepository repository;
  final int todoId;
  late List<Subtask> previusData = [];

  SubtaskBloc({
    required this.todoId,
    required this.repository,
  }) : super(const SubtasksLoadingState(subtasks: [])) {
    on<FetchSubtasksEvent>(_mapFetchSubtasks);
    on<AddSubtaskEvent>(_mapAddSubtask);
    on<UpdateSubtaskEvent>(_mapUpdateSubtasks);
    on<DeleteSubtaskEvent>(_mapDeleteSubtask);
  }

  Future<void> _mapFetchSubtasks(
      FetchSubtasksEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(SubtasksLoadingState(subtasks: previusData));
      previusData = await repository.fetch(todoId: todoId);
      emit(SubtasksLoadedState(subtasks: previusData));
    } on Exception catch (error) {
      emit(SubtaskErrorState(subtasks: previusData, error: error));
    }
  }

  Future<void> _mapAddSubtask(
      AddSubtaskEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(SubtasksLoadingState(subtasks: previusData));
      repository.insert(event.subtask);
      previusData = await repository.fetch(todoId: todoId);
      emit(SubtasksLoadedState(subtasks: previusData));
    } on Exception catch (error) {
      emit(SubtaskErrorState(subtasks: previusData, error: error));
    }
  }

  Future<void> _mapUpdateSubtasks(
      UpdateSubtaskEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(SubtasksLoadingState(subtasks: previusData));
      repository.update(event.subtask);
      previusData = await repository.fetch(todoId: todoId);
      emit(SubtasksLoadedState(subtasks: previusData));
    } on Exception catch (error) {
      emit(SubtaskErrorState(subtasks: previusData, error: error));
    }
  }

  Future<void> _mapDeleteSubtask(
      DeleteSubtaskEvent event, Emitter<SubtaskState> emit) async {
    try {
      emit(SubtasksLoadingState(subtasks: previusData));
      repository.delete(event.id);
      previusData = await repository.fetch(todoId: todoId);
      emit(SubtasksLoadedState(subtasks: previusData));
    } on Exception catch (error) {
      emit(SubtaskErrorState(subtasks: previusData, error: error));
    }
  }
}

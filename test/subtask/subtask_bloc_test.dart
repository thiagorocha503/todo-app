import 'package:bloc_test/bloc_test.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/mock/subtask_repository_mock.dart';

void main() {
  List<Subtask> data = const [
    Subtask(id: 1, name: "a", complete: false, todoId: 1),
    Subtask(id: 2, name: "b", complete: true, todoId: 1),
    Subtask(id: 3, name: "c", complete: false, todoId: 1),
    Subtask(id: 4, name: "d", complete: false, todoId: 2),
  ];

  blocTest<SubtaskBloc, SubtaskState>(
    'emits [SubtasksLoadingState, SubtasksLoadedState] '
    'when [FetchSubtasksEvent] is added.',
    build: () => SubtaskBloc(
      todoId: 1,
      repository: SubtasksRepositoryMock(subtasks: data),
    ),
    act: (bloc) => bloc.add(FetchSubtasksEvent()),
    expect: () => const <SubtaskState>[
      SubtasksLoadingState(subtasks: []),
      SubtasksLoadedState(subtasks: [
        Subtask(id: 1, name: "a", complete: false, todoId: 1),
        Subtask(id: 2, name: "b", complete: true, todoId: 1),
        Subtask(id: 3, name: "c", complete: false, todoId: 1),
      ])
    ],
  );

  blocTest<SubtaskBloc, SubtaskState>(
    'emits [SubtasksLoadingState, SubtasksLoadedState] '
    'when [AddSubtaskEvent] is added.',
    build: () => SubtaskBloc(
      todoId: 1,
      repository: SubtasksRepositoryMock(subtasks: data),
    ),
    act: (bloc) => bloc.add(
      AddSubtaskEvent(
        subtask: const Subtask(
          id: 4,
          name: 'lorem ispum',
          complete: false,
          todoId: 1,
        ),
      ),
    ),
    expect: () => const <SubtaskState>[
      SubtasksLoadingState(subtasks: []),
      SubtasksLoadedState(subtasks: [
        Subtask(id: 1, name: "a", complete: false, todoId: 1),
        Subtask(id: 2, name: "b", complete: true, todoId: 1),
        Subtask(id: 3, name: "c", complete: false, todoId: 1),
        Subtask(id: 4, name: "lorem ispum", complete: false, todoId: 1),
      ])
    ],
  );

  blocTest<SubtaskBloc, SubtaskState>(
    'emits [SubtasksLoadingState, SubtasksLoadedState] '
    'when [DeleteSubtaskEvent] is added.',
    build: () => SubtaskBloc(
      todoId: 1,
      repository: SubtasksRepositoryMock(subtasks: data),
    ),
    act: (bloc) => bloc.add(DeleteSubtaskEvent(id: 2)),
    expect: () => const <SubtaskState>[
      SubtasksLoadingState(subtasks: []),
      SubtasksLoadedState(subtasks: [
        Subtask(id: 1, name: "a", complete: false, todoId: 1),
        Subtask(id: 3, name: "c", complete: false, todoId: 1),
      ])
    ],
  );

  blocTest<SubtaskBloc, SubtaskState>(
    'emits [SubtasksLoadingState, SubtasksLoadedState] '
    'when [UpdateSubtaskEvent] is added.',
    build: () => SubtaskBloc(
      todoId: 1,
      repository: SubtasksRepositoryMock(subtasks: data),
    ),
    act: (bloc) => bloc.add(
      UpdateSubtaskEvent(
        subtask: const Subtask(
          id: 2,
          name: 'x',
          complete: false,
          todoId: 1,
        ),
      ),
    ),
    expect: () => const <SubtaskState>[
      SubtasksLoadingState(subtasks: []),
      SubtasksLoadedState(subtasks: [
        Subtask(id: 1, name: "a", complete: false, todoId: 1),
        Subtask(id: 2, name: "x", complete: false, todoId: 1),
        Subtask(id: 3, name: "c", complete: false, todoId: 1),
      ])
    ],
  );
}

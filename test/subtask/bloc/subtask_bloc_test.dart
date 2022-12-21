import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/repository/repository.dart';
import 'package:todo/subtask/repository/subtask_repository.mocks.dart';

void main() {
  late SubtaskBloc bloc;
  late ISubtaskRepository repository;

  List<Subtask> data = const [
    Subtask(id: 1, name: "a", complete: false, todoId: 1),
    Subtask(id: 2, name: "b", complete: true, todoId: 1),
    Subtask(id: 3, name: "c", complete: false, todoId: 1),
  ];

  setUp(() {
    repository = MockSubtaskRepository();
    when(repository.fetch(todoId: 1)).thenAnswer((realInvocation) async {
      return await Future.value(data);
    });
    bloc = SubtaskBloc(
      todoId: 1,
      repository: repository,
    );
  });

  blocTest<SubtaskBloc, SubtaskState>(
    'Fetched subtask event',
    build: () => bloc,
    act: (bloc) => bloc.add(FetchSubtasksEvent()),
    verify: (_) {
      verify(repository.fetch(todoId: 1));
    },
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
    'Added subtask event',
    setUp: () {
      when(repository.fetch(todoId: 1)).thenAnswer((realInvocation) async {
        return Future.value(const [
          Subtask(id: 1, name: "a", complete: false, todoId: 1),
          Subtask(id: 2, name: "b", complete: true, todoId: 1),
          Subtask(id: 3, name: "c", complete: false, todoId: 1),
          Subtask(id: 4, name: "lorem ispum", complete: false, todoId: 1),
        ]);
      });
    },
    build: () => bloc,
    verify: (_) {
      verify(repository.insert(
        const Subtask(
          id: 4,
          name: 'lorem ispum',
          complete: false,
          todoId: 1,
        ),
      ));
      verify(repository.fetch(todoId: 1));
    },
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
    'Deleted subtask event',
    build: () => bloc,
    setUp: () {
      when(repository.fetch(todoId: 1)).thenAnswer((realInvocation) async {
        return Future.value(const [
          Subtask(id: 1, name: "a", complete: false, todoId: 1),
          Subtask(id: 3, name: "c", complete: false, todoId: 1),
        ]);
      });
    },
    verify: (_) {
      verify(repository.delete(2));
      verify(repository.fetch(todoId: 1));
    },
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
    'Updated  subtask event',
    build: () => bloc,
    setUp: () {
      when(repository.fetch(todoId: 1)).thenAnswer((realInvocation) async {
        return Future.value(const [
          Subtask(id: 1, name: "a", complete: false, todoId: 1),
          Subtask(id: 2, name: "x", complete: false, todoId: 1),
          Subtask(id: 3, name: "c", complete: false, todoId: 1)
        ]);
      });
    },
    verify: (_) {
      verify(repository.update(
        const Subtask(id: 2, name: "x", complete: false, todoId: 1),
      ));
      verify(repository.fetch(todoId: 1));
    },
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

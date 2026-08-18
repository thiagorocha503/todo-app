import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';

class SubtaskRepositoryMock extends Mock implements SubtaskRepository {}

class SubtaskFake extends Fake implements Subtask {}

void main() {
  const List<Subtask> mockSubtask = [
    Subtask(id: 1, name: "subtask 1", complete: false, todoId: 1),
    Subtask(id: 2, name: "subtask 2", complete: false, todoId: 1),
    Subtask(id: 3, name: "subtask 3", complete: false, todoId: 1),
    Subtask(id: 4, name: "subtask 4", complete: false, todoId: 1),
  ];

  group("SubtaskBloc", () {
    late SubtaskRepository subtaskRepository;

    setUpAll(() {
      registerFallbackValue(SubtaskFake());
    });

    setUp(() {
      subtaskRepository = SubtaskRepositoryMock();
      when(
        () => subtaskRepository.getSubtasks(),
      ).thenAnswer((_) => Stream.value(mockSubtask));
      when(() => subtaskRepository.save(any())).thenAnswer((_) async {});
    });

    SubtaskBloc buildBloc() {
      return SubtaskBloc(
        SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        repository: subtaskRepository,
      );
    }

    group("constructor", () {
      test("works properly", () => expect(buildBloc, returnsNormally));
      test("has correct initial state", () {
        expect(
          buildBloc().state,
          equals(SubtaskLoadedState(subtasks: mockSubtask, taskId: 1)),
        );
      });
    });

    group('SubtaskSubscriptionRequested', () {
      blocTest<SubtaskBloc, SubtaskState>(
        'starts listening to repository getSubtasks stream',
        build: buildBloc,
        act: (bloc) => bloc.add(SubtaskSubscriptionRequested()),
        verify: (_) {
          verify(() => subtaskRepository.getSubtasks()).called(1);
        },
      );

      blocTest<SubtaskBloc, SubtaskState>(
        'emits SubtaskLoadedState '
        'when repository getSubtasks stream emits new subtasks',
        build: buildBloc,
        act: (bloc) => bloc.add(SubtaskSubscriptionRequested()),
        expect: () => [
          SubtasksLoadingState(subtasks: mockSubtask, taskId: 1),
          SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        ],
      );

      blocTest<SubtaskBloc, SubtaskState>(
        'emits SubtaskErrorState '
        'when repository getSubtasks stream emits error',
        build: buildBloc,
        setUp: () {
          when(() => subtaskRepository.getSubtasks()).thenAnswer(
            (_) => Stream.error(Exception('Failed to fetch subtask')),
          );
        },
        act: (bloc) => bloc.add(SubtaskSubscriptionRequested()),
        expect: () => [
          SubtasksLoadingState(subtasks: mockSubtask, taskId: 1),
          SubtaskErrorState(
            subtasks: mockSubtask,
            error: Exception('Exception: Failed to fetch subtask'),
            taskId: 1,
          ),
        ],
      );
    });

    group("SubtaskAddedEvent", () {
      blocTest(
        "saves new subtask to repository",
        build: buildBloc,
        seed: () => SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        act: (bloc) {
          bloc.add(SubtaskAddedEvent(title: "subtask 5", taskId: 1));
        },
        verify: (_) {
          verify(
            () => subtaskRepository.save(
              Subtask(name: "subtask 5", complete: false, todoId: 1),
            ),
          ).called(1);
        },
      );
    });

    group("SubtaskDeletedEvent", () {
      blocTest(
        "deletes subtask using repository",
        build: buildBloc,
        setUp: () {
          when(() => subtaskRepository.delete(any())).thenAnswer((_) async {});
        },
        act: (bloc) {
          bloc.add(SubtaskDeletedEvent(id: 2));
        },
        seed: () => SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        verify: (_) {
          verify(() => subtaskRepository.delete(2)).called(1);
        },
      );
    });

    group("SubtaskTitleChangedEvent", () {
      blocTest(
        "saves subtask with updated title to repository",
        build: buildBloc,
        seed: () => SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        act: (bloc) {
          bloc.add(SubtaskTitleChangedEvent(id: 2, title: "subtask A"));
        },
        verify: (_) {
          verify(
            () => subtaskRepository.save(
              Subtask(id: 2, name: "subtask A", complete: false, todoId: 1),
            ),
          ).called(1);
        },
      );
    });

    group("SubtaskCompletionToggledEvent", () {
      blocTest(
        "saves subtask with updated completion status",
        build: buildBloc,
        seed: () => SubtaskLoadedState(subtasks: mockSubtask, taskId: 1),
        act: (bloc) {
          bloc.add(SubtaskCompletionToggledEvent(id: 3, isCompleted: true));
        },
        verify: (_) {
          verify(
            () => subtaskRepository.save(
              Subtask(id: 3, name: "subtask 3", complete: true, todoId: 1),
            ),
          ).called(1);
        },
      );
    });
  });
}

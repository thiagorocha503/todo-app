import 'package:bloc_test/bloc_test.dart';
import 'package:todo/subtask/ui/widget/subtask_input.dart';

void main() {
  blocTest<SubtaskInputBloc, SubtaskInputState>(
    'Unselected event',
    build: () => SubtaskInputBloc(state: SubtaskInputState.selected),
    act: (bloc) => bloc.change(SubtaskInputState.unselected),
    expect: () => const <SubtaskInputState>[SubtaskInputState.unselected],
  );

  blocTest<SubtaskInputBloc, SubtaskInputState>(
    'Selected event',
    build: () => SubtaskInputBloc(state: SubtaskInputState.unselected),
    act: (bloc) => bloc.change(SubtaskInputState.selected),
    expect: () => const <SubtaskInputState>[SubtaskInputState.selected],
  );
}

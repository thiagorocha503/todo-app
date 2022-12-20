import 'package:bloc_test/bloc_test.dart';
import 'package:todo/subtask/ui/widget/subtask_input.dart';

void main() {
  blocTest<SubtaskInputBloc, SubtaskInputState>(
    'emits SubtaskInputState.unselected when SubtaskInputState.unselected is added.',
    build: () => SubtaskInputBloc(state: SubtaskInputState.selected),
    act: (bloc) => bloc.change(SubtaskInputState.unselected),
    expect: () => const <SubtaskInputState>[SubtaskInputState.unselected],
  );

  blocTest<SubtaskInputBloc, SubtaskInputState>(
    'emits SubtaskInputState.selected when SubtaskInputState.selected is added.',
    build: () => SubtaskInputBloc(state: SubtaskInputState.unselected),
    act: (bloc) => bloc.change(SubtaskInputState.selected),
    expect: () => const <SubtaskInputState>[SubtaskInputState.selected],
  );
}

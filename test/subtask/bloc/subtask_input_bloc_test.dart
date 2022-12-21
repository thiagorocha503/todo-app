import 'package:bloc_test/bloc_test.dart';
import 'package:todo/subtask/ui/subtask_add_list_tile.dart';

void main() {
  blocTest<SubtaskInputBloc, SubtaskInputAddState>(
    'Disabled event',
    build: () => SubtaskInputBloc(state: SubtaskInputAddState.enabled),
    act: (bloc) => bloc.change(SubtaskInputAddState.disabled),
    expect: () => const <SubtaskInputAddState>[SubtaskInputAddState.disabled],
  );

  blocTest<SubtaskInputBloc, SubtaskInputAddState>(
    'Enabled event',
    build: () => SubtaskInputBloc(state: SubtaskInputAddState.disabled),
    act: (bloc) => bloc.change(SubtaskInputAddState.enabled),
    expect: () => const <SubtaskInputAddState>[SubtaskInputAddState.enabled],
  );
}

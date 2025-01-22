import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/ui/widget/description_page.dart';

class DescriptinCubit extends Cubit<String> {
  DescriptinCubit(super.initialState);

  void change(String descriptin) {
    emit(descriptin);
  }
}

class DescriptionListTile extends StatelessWidget {
  final Function(String text) onChange;
  final String initialDescription;
  const DescriptionListTile(
      {super.key, required this.onChange, required this.initialDescription});

  @override
  Widget build(BuildContext context) {
    double height = 100;
    return BlocProvider(
      create: (context) => DescriptinCubit(initialDescription),
      child: BlocBuilder<DescriptinCubit, String>(
        builder: (context, description) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<TodoEditBloc>(),
                      child: BlocProvider.value(
                        value: context.read<DescriptinCubit>(),
                        child: DescriptionPage(
                          onChange: (t) {
                            onChange(t);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              shadowColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 20),
                height: height,
                width: double.infinity,
                child: Text(
                  description == ""
                      ? AppLocalizations.of(context).addDescription
                      : description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 8,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

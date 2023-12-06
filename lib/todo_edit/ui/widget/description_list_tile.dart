import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/ui/widget/description_page.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class DescriptionListTile extends StatelessWidget {
  final String note;
  final Function(String value) onChange;
  const DescriptionListTile({
    Key? key,
    required this.note,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 100;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              TodoEditBloc bloc = context.read();
              return BlocProvider.value(
                value: bloc,
                child: DescriptionPage(initialNote: note, onSave: onChange),
              );
            },
          ),
        );
      },
      child: Card(
        shadowColor: Colors.transparent,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
          height: height,
          width: double.infinity,
          child: Text(
            note == ""
                ? AppLocalizations.of(context).addDescription.capitalize()
                : note,
            overflow: TextOverflow.ellipsis,
            maxLines: 8,
          ),
        ),
      ),
    );
  }
}

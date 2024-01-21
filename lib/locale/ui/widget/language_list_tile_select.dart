import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class LanguageListTileSelect extends StatelessWidget {
  final String code;
  final String name;
  const LanguageListTileSelect(
      {super.key, required this.code, required this.name});

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    if (context.read<LocaleCubit>().state.locale.languageCode == code) {
      selected = true;
    }
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        trailing: selected
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
            : null,
        title: Text(
          name.capitalize(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          context.read<LocaleCubit>().change(Locale(code));
        },
      ),
    );
  }
}

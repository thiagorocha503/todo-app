import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/language/ui/language_page.dart';
import 'package:todo/util/string_extension.dart';

class LanguageListTileSelect extends StatelessWidget {
  final LanguageItem language;
  const LanguageListTileSelect({required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    if (context.read<LanguageCubit>().state == Locale(language.code.name)) {
      selected = true;
    }
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        trailing: selected
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.secondary)
            : null,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            language.name.toString().capitalize(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          context.read<LanguageCubit>().change(language.code);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/language/ui/language_page.dart';

class LanguageListTile extends StatelessWidget {
  final LanguageItem language;
  const LanguageListTile({required this.language, super.key});

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    if (context.read<LanguageCubit>().state == Locale(language.code.name)) {
      selected = true;
    }
    return ListTile(
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.secondary)
          : null,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          language.name.toString().toUpperCase(),
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.9),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      onTap: () {
        context.read<LanguageCubit>().change(language.code);
      },
    );
  }
}

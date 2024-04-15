import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';

class LanguageListTileOption extends StatelessWidget {
  final String code;
  const LanguageListTileOption({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing:
          BlocProvider.of<LocaleCubit>(context).state.locale.languageCode ==
                  code
              ? Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          languages[code].toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      onTap: () {
        BlocProvider.of<LocaleCubit>(context).change(Locale(code));
      },
    );
  }
}

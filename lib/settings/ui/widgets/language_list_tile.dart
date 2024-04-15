import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/locale/ui/language_page.dart';

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(
        AppLocalizations.of(context).language,
      ),
      subtitle: Text(
          languages[context.read<LocaleCubit>().state.locale.languageCode] ??
              "none"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LanguagePage()),
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
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
      subtitle: Text(getCurrentLanguage(context)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => LanguagePage())),
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }

  String getCurrentLanguage(BuildContext context) {
    String lang = context.read<LocaleCubit>().state.locale.languageCode;
    switch (lang) {
      case "en":
        return "english";
      case "pt":
        return "português";
      case "es":
        return "espanõl";
      default:
        return "";
    }
  }
}

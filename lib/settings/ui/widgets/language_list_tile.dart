import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/locale/ui/language_page.dart';
import 'package:todo/util/string_extension.dart';
import 'package:provider/provider.dart';

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(
        AppLocalizations.of(context).translate("language").capitalize(),
      ),
      subtitle: Text(getCurrentLanguage(context).capitalize()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => const LanguagePage())),
        );
      },
    );
  }

  String getCurrentLanguage(BuildContext context) {
    String lang = context.read<LocaleCubit>().state.languageCode;
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

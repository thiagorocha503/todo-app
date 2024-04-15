import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/locale/ui/widget/language_list_tile_select.dart';

class LanguageItem {
  final String name;
  final String code;
  LanguageItem({required this.name, required this.code});
}

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final List<LanguageItem> languages = [
    LanguageItem(name: "english", code: "en"),
    LanguageItem(name: "português", code: "pt"),
    LanguageItem(name: "español", code: "es"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).language,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return LanguageListTileSelect(
              code: languages[index].code,
              name: languages[index].name,
            );
          },
        ),
      ),
    );
  }
}

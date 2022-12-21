import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/language/model/language.dart';
import 'package:todo/language/ui/widget/language_list_tile.dart';
import 'package:todo/util/string_extension.dart';

class LanguageItem {
  final String name;
  final Language code;
  LanguageItem({required this.name, required this.code});
}

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final List<LanguageItem> languages = [
    LanguageItem(name: "english", code: Language.en),
    LanguageItem(name: "português", code: Language.pt),
    LanguageItem(name: "español", code: Language.es),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate("language").capitalize(),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return LanguageListTile(language: languages[index]);
          },
        ),
      ),
    );
  }
}

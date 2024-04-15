import 'package:flutter/material.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/locale/ui/widget/language_list_tile_option.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> keys = languages.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).language,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) => LanguageListTileOption(
            code: keys[index],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/language/model/language.dart';
import 'package:todo/util/string_extension.dart';

class LanguageItem {
  final String name;
  final Language code;
  LanguageItem({required this.name, required this.code});
}

class LanguagePage extends StatelessWidget {
  final List<LanguageItem> language = [
    LanguageItem(name: "english", code: Language.en),
    LanguageItem(name: "português", code: Language.pt),
    LanguageItem(name: "español", code: Language.es),
  ];

  LanguagePage({super.key});

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
          itemCount: language.length,
          itemBuilder: (context, index) {
            if (context.read<LanguageCubit>().state ==
                Locale(language[index].code.name)) {
              return buildItem(context, index, selected: true);
            }
            return buildItem(context, index);
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index, {bool selected = false}) {
    return ListTile(
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.secondary)
          : null,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          language[index].name.toString().toUpperCase(),
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.9),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      onTap: () {
        context.read<LanguageCubit>().change(language[index].code);
      },
    );
  }
}

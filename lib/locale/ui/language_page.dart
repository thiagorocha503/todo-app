import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/util/string_extension.dart';

class LanguagePage extends StatelessWidget {
  final List<Map<dynamic, dynamic>> language = const [
    {"name": "english", "code": "en"},
    {"name": "português", "code": "pt"},
    {"name": "espanõl", "code": "es"},
  ];

  const LanguagePage({super.key});

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
      body: ListView.builder(
        itemCount: language.length,
        itemBuilder: (context, index) {
          if (context.read<LocaleCubit>().state.languageCode ==
              language[index]["code"]) {
            return buildItem(context, index, selected: true);
          }
          return buildItem(context, index);
        },
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
          language[index]["name"].toString().toUpperCase(),
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.9),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      onTap: () {
        context.read<LocaleCubit>().change(Locale(language[index]["code"]));
      },
    );
  }
}

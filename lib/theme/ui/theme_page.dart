import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/ui/widget/theme_list_tile_select.dart';

class ThemeItem {
  final String name;
  final ThemeMode value;

  ThemeItem({required this.name, required this.value});
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ThemeItem> themes = [
      ThemeItem(
        name: AppLocalizations.of(context).system,
        value: ThemeMode.system,
      ),
      ThemeItem(
        name: AppLocalizations.of(context).light,
        value: ThemeMode.light,
      ),
      ThemeItem(
        name: AppLocalizations.of(context).dark,
        value: ThemeMode.dark,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).theme),
      ),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, appTheme) {
          return ListView.builder(
            itemCount: themes.length,
            itemBuilder: (context, index) {
              ThemeItem theme = themes[index];
              return ThemeListTileSelect(themeItem: theme);
            },
          );
        },
      ),
    );
  }
}

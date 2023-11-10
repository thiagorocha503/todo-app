import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/ui/theme_page.dart';
import 'package:todo/util/string_extension.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: Text(
        AppLocalizations.of(context).theme.capitalize(),
      ),
      subtitle: const SubtitleTheme(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ThemePage()),
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}

class SubtitleTheme extends StatelessWidget {
  const SubtitleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        String text;
        switch (state) {
          case ThemeMode.light:
            text = AppLocalizations.of(context).light;
            break;
          case ThemeMode.dark:
            text = AppLocalizations.of(context).dark;
            break;
          case ThemeMode.system:
            text = AppLocalizations.of(context).system;
            break;
        }
        return Text(text.capitalize());
      },
    );
  }
}

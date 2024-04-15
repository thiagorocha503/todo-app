import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/date_formatter.dart';

class Footer extends StatelessWidget {
  final DateTime? createdAt;
  final DateTime? completeAt;
  const Footer({super.key, this.createdAt, this.completeAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (createdAt != null)
            Text(
              AppLocalizations.of(context).createdAt(
                DateFormatter(
                  AppLocalizations.of(context),
                  Localizations.localeOf(context),
                ).getVerboseDateRepresentation(createdAt!.toLocal(), context),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          if (completeAt != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                AppLocalizations.of(context).completedAt(
                  DateFormatter(AppLocalizations.of(context),
                          Localizations.localeOf(context))
                      .getVerboseDateRepresentation(
                          completeAt!.toLocal(), context),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
        ],
      ),
    );
  }
}

import 'package:todo/app_localizations.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  final AppLocalizations appLocalizations;

  DateFormatter(this.appLocalizations);

  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = DateTime.now().subtract(const Duration(minutes: 1));
    DateTime localeDateTime = dateTime.toLocal();
    // just now: less than a minute old
    if (!localeDateTime.difference(justNow).isNegative) {
      return appLocalizations.translate("just-now");
    }
    // case today
    String roughTimeString =
        DateFormat('jm', appLocalizations.locale.languageCode)
            .format(localeDateTime);
    if (localeDateTime.day == now.day &&
        localeDateTime.month == now.month &&
        localeDateTime.year == now.year) {
      return "${appLocalizations.translate("today")}, $roughTimeString";
    }
    // case yesterday
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (localeDateTime.day == yesterday.day &&
        localeDateTime.month == yesterday.month &&
        localeDateTime.year == yesterday.year) {
      return "${appLocalizations.translate("yesterday")}, $roughTimeString";
    }
    // case couple of day: less old than 4 days
    if (now.difference(localeDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE', appLocalizations.locale.languageCode)
          .format(localeDateTime);
      return "$weekday, $roughTimeString";
    }
    if (localeDateTime.year == now.year) {
      return "${DateFormat("yMMMd", appLocalizations.locale.languageCode).format(localeDateTime)} ${DateFormat("jm", appLocalizations.locale.languageCode).format(localeDateTime)}";
    }
    // otherwise
    return "${DateFormat('yMd', appLocalizations.locale.languageCode).format(dateTime)}, $roughTimeString";
  }
}

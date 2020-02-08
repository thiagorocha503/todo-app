class Validation {
  
  static bool isDateValida(String date) {
    String expression =
        r"^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$";
    RegExp regex = new RegExp(expression);
    if (!regex.hasMatch(date)) {
      return false;
    }
    int day = int.parse(date.substring(0, 2));
    int month = int.parse(date.substring(3, 5));
    int year = int.parse(date.substring(6, 10));
    print("day: $day, month: $month, year: $year");
    if (month == 2) {
      if (day <= 29 && isYearBissexto(year)) {
        return true;
      } else if (day <= 28 && !isYearBissexto(year)) {
        return true;
      } else {
        return false;
      }
    } else if ((month == 4 || month == 6 || month == 9 || month == 11) &&
        day <= 30) {
      return true;
    } else {
      // mese com 31 dias
      if (day <= 31) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool isYearBissexto(int year) {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return true;
    } else {
      return false;
    }
  }
}

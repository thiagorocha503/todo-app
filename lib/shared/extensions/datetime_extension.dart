extension DateCompare on DateTime {
  int compareDateTo(DateTime data) {
    if (year < data.year) {
      return -1;
    } else if (year > data.year) {
      return 1;
    } else {
      if (month < data.month) {
        return -1;
      } else if (month > data.month) {
        return 1;
      } else {
        if (day < data.day) {
          return -1;
        } else if (day > data.day) {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }
}

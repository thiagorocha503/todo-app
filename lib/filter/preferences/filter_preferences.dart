import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/filter/model/filter.dart';

class FilterPreferences {
  SharedPreferences preferences;
  FilterPreferences({required this.preferences});

  final String key = "todo_filter";

  void setFilter(Filter filter) {
    preferences.setString(key, filter.name);
  }

  Filter getFilter() {
    String? value = preferences.getString(key);
    if (value == Filter.all.name) {
      return Filter.all;
    } else if (value == Filter.done.name) {
      return Filter.done;
    } else if (value == Filter.active.name) {
      return Filter.active;
    } else {
      setFilter(Filter.all);
      return Filter.all;
    }
  }
}

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/filter/model/filter.dart';

class FilterPreferences {
  SharedPreferences preferences;
  final String key = "todo_filter";
  FilterPreferences({required this.preferences});

  final StreamController<Filter> _controller = StreamController();
  Stream<Filter> get stream => _controller.stream;
  Sink<Filter> get sink => _controller.sink;

  set filter(Filter filter) {
    preferences.setString(key, filter.name);
    _controller.sink.add(filter);
  }

  Filter get filter {
    String? value = preferences.getString(key);
    if (value == Filter.all.name) {
      return Filter.all;
    } else if (value == Filter.done.name) {
      return Filter.done;
    } else if (value == Filter.active.name) {
      return Filter.active;
    } else {
      filter = Filter.all;
      return Filter.all;
    }
  }
}

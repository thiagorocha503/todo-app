import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/filter/preferences/filter_preferences.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';

class FilterCubit extends Cubit<Filter> {
  TodoOverViewBloc bloc;
  FilterPreferences preferences;
  FilterCubit(
      {required this.preferences, required this.bloc, required Filter filter})
      : super(filter) {
    preferences.stream.listen((Filter filter) {
      emit(filter);
      bloc.add(TodoOverFilterChange(filter: filter));
    });
  }

  void change(Filter filter) {
    preferences.sink.add(filter);
  }
}

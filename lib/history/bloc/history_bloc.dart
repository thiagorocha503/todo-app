import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todo/constants.dart';
import 'package:todo/shared/data/user_preferences.dart';
import './bloc.dart';

class HistoricBloc extends Bloc<HistoryEvent, HistoryState> {
  final UserPreferences _preferences;
  HistoricBloc(UserPreferences preferences)
      : _preferences = preferences,
        super(const HistoryState(histories: [])) {
    _preferences.getLocale();
    on<HistoryAdded>((event, emit) async {
      _preferences.addHistory(event.query);

      emit(HistoryState(histories: _preferences.getHistories()));
    });
    on<HistoryCleaned>((event, emit) {
      preferences.clearHistory();
      emit(const HistoryState(histories: []));
    });
  }
}

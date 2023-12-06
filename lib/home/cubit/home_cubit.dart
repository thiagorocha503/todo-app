import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/cubit/home_state.dart';
import 'package:todo/home/model/home_tab.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  void changeDestinationSelected(HomeTab tab) {
    emit(HomeState(tab: tab));
  }

  void showNavigation() {
    emit(state.copyWith(show: true));
  }

  void hideNavigation() {
    emit(state.copyWith(show: false));
  }
}

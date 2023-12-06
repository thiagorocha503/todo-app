import 'package:equatable/equatable.dart';
import 'package:todo/home/model/home_tab.dart';

class HomeState extends Equatable {
  final HomeTab tab;
  final bool show;

  const HomeState({required this.tab, this.show = true});

  @override
  List<Object?> get props => [tab, show];

  HomeState copyWith({HomeTab? tab, bool? show}) {
    return HomeState(tab: tab ?? this.tab, show: show ?? this.show);
  }
}

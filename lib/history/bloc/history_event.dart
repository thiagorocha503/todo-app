import 'package:equatable/equatable.dart';

class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryAdded extends HistoryEvent {
  final String query;

  HistoryAdded({required this.query});

  @override
  List<Object?> get props => [query];
}

class HistoryCleaned extends HistoryEvent {}

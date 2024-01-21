import 'package:equatable/equatable.dart';

class HistoryState extends Equatable {
  final List<String> histories;

  const HistoryState({required this.histories});

  @override
  List<Object?> get props => [histories];
}

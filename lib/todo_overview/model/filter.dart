import 'package:equatable/equatable.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/shared/model/wrapped.dart';

class TodoFilter extends Equatable {
  final String? query;
  final DateTime? dueDate;
  final Listing? listing;
  final bool? showComplete;

  const TodoFilter(
      {this.query, this.dueDate, this.listing, this.showComplete = true});
  TodoFilter copyWith(
      {Wrapped<DateTime?>? dueDate,
      Wrapped<bool?>? showComplete,
      Wrapped<Listing?>? listing,
      Wrapped<String?>? query}) {
    return TodoFilter(
      query: query != null ? query.value : this.query,
      dueDate: dueDate != null ? dueDate.value : this.dueDate,
      listing: listing != null ? listing.value : this.listing,
      showComplete:
          showComplete != null ? showComplete.value : this.showComplete,
    );
  }

  @override
  List<Object?> get props => [
        query,
        dueDate?.millisecondsSinceEpoch,
        listing,
        showComplete,
      ];

  @override
  String toString() {
    return "{query: $query,  due_date:${dueDate?.toIso8601String()}, showComplete: $showComplete, listing: $listing}";
  }
}

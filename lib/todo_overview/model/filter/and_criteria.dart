import 'package:todo/todo_overview/model/filter/criteria.dart';

class AndCriteria<T> implements Criteria<T> {
  final List<Criteria<T>> criterias;

  AndCriteria(this.criterias);

  @override
  bool matches(T item) {
    for (final criteria in criterias) {
      if (!criteria.matches(item)) {
        return false;
      }
    }
    return true;
  }
}

class TodoPriorityException implements Exception {
  int priority;

  TodoPriorityException(this.priority);

  @override
  String toString() {
    return "NotePriorityException: invalid priority <${this.priority}>";
  }
}

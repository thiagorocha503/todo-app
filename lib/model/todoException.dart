class TodoPriorityException implements Exception {
  int priority;

  TodoPriorityException(this.priority);

  @override
  String toString() {
    return "NotePriorityException: prioridade invalid <${this.priority}>";
  }
}

class NoteDateIntervaloException implements Exception {
  String message;

  NoteDateIntervaloException(this.message);

  String toString() {
    return "NoteDateIntervaloException: ${this.message}";
  }
}

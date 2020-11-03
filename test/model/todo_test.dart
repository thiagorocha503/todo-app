import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:lista_de_tarefas/model/todoException.dart';
import 'package:matcher/matcher.dart';

void main() {
  group("Todo test", () {
    test("Test priority", () {
      Todo todo = Todo();
      TypeMatcher<Exception> exception =
          new TypeMatcher<TodoPriorityException>();
      expect(() => todo.setPriority(-1), throwsA(exception));
      expect(() => todo.setPriority(Todo.PRIORITY_HIGH), returnsNormally);
      expect(() => todo.setPriority(Todo.PRIORITY_NORMAL), returnsNormally);
      expect(() => todo.setPriority(Todo.PRIORITY_LOW), returnsNormally);
      expect(() => todo.setPriority(3), throwsA(exception));
    });
  });
}

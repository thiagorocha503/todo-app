import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/model/todo.dart';
import 'package:lista_de_tarefas/model/todoException.dart';
import 'package:matcher/matcher.dart';

void main() {
  group("Test priority", () {
    test("Test priority valid", () {
      Todo todo = Todo();
      expect(() => todo.setPriority(Todo.PRIORITY_HIGH), returnsNormally);
      expect(() => todo.setPriority(Todo.PRIORITY_NORMAL), returnsNormally);
      expect(() => todo.setPriority(Todo.PRIORITY_LOW), returnsNormally);
    });
    test("Test priority invalid", () {
      Todo todo = Todo();
      expect(() => todo.setPriority(-1),
          throwsA(TypeMatcher<TodoPriorityException>()));
      expect(() => todo.setPriority(3),
          throwsA(TypeMatcher<TodoPriorityException>()));
    });
  });

  group("Test prazo", () {
    DateTime today = DateTime.now();
    test("Test date start", () {
      Todo todo = Todo();
      expect(() => todo.setDateEnd(today), returnsNormally);
      expect(
          () => todo
              .setDateStart(DateTime(today.year, today.month, today.day - 5)),
          returnsNormally);
      expect(
          () => todo
              .setDateStart(DateTime(today.year, today.month, today.day + 5)),
          throwsA(TypeMatcher<NoteDateIntervaloException>()));
    });
    test("Test date end", () {
      Todo todo = Todo();
      expect(() => todo.setDateStart(today), returnsNormally);
      expect(
          () =>
              todo.setDateEnd(DateTime(today.year, today.month, today.day + 5)),
          returnsNormally);
      expect(
          () =>
              todo.setDateEnd(DateTime(today.year, today.month, today.day - 5)),
          throwsA(TypeMatcher<NoteDateIntervaloException>()));
    });
  });
}

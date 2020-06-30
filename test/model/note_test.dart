
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/model/note.dart';
import 'package:lista_de_tarefas/model/noteException.dart';
import 'package:matcher/matcher.dart';

void main() {
  
  group("Test priority", () {
    test("Test priority valid", () {
      Note todo = Note();
      expect(() => todo.setPriority(Note.PRIORITY_HIGH), returnsNormally);
      expect(() => todo.setPriority(Note.PRIORITY_NORMAL), returnsNormally);
      expect(() => todo.setPriority(Note.PRIORITY_LOW), returnsNormally);
    });
    test("Test priority invalid", () {
      Note todo = Note();
      expect(() => todo.setPriority(-1),
          throwsA(TypeMatcher<NotePriorityException>()));
      expect(() => todo.setPriority(3),
          throwsA(TypeMatcher<NotePriorityException>()));
    });
  });


  group("Test prazo", (){
    DateTime today = DateTime.now();
    test("Test date start", (){
      Note todo = Note();
      expect(()=> todo.setDateEnd(today), returnsNormally);
      expect(()=> todo.setDateStart(DateTime(today.year, today.month, today.day-5)), returnsNormally);
      expect(()=> todo.setDateStart(DateTime(today.year, today.month, today.day+5)),throwsA(TypeMatcher<NoteDateIntervaloException>()));

    });
     test("Test date end", (){
      Note todo = Note();
      expect(()=> todo.setDateStart(today), returnsNormally);
      expect(()=> todo.setDateEnd(DateTime(today.year, today.month, today.day+5)), returnsNormally);
      expect(()=> todo.setDateEnd(DateTime(today.year, today.month, today.day-5)),throwsA(TypeMatcher<NoteDateIntervaloException>()));
    });

  });
}

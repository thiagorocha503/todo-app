import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/view/tarefaEditPage.dart';

MediaQuery getApp() {
  Map todo = {
    "id": 1,
    "title": "title",
    "description": "description",
    "dateStart": "07/02/2020",
    "dateEnd": "14/02/2020",
    "priority": 1,
    "done": false
  };
  return new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: TarefaEditPage(todo: todo)));
}

void main() {
  testWidgets("Teste campo em branco", (tester) async {
    // prepara app
    await tester.pumpWidget(getApp());

    Form form = tester.widget(find.byType(Form));
    GlobalKey<FormState> formKey = form.key;

    // formulario inicial
    expect(true, formKey.currentState.validate());

    // limpa  campos
    await tester.enterText(find.byKey(Key("txtTitle")), "");
    expect(false, formKey.currentState.validate());

    await tester.enterText(find.byKey(Key("txtDescription")), "");
    expect(false, formKey.currentState.validate());

    await tester.enterText(find.byKey(Key("txtDateStart")), "");
    expect(false, formKey.currentState.validate());

    await tester.enterText(find.byKey(Key("txtDateEnd")), "");
    expect(false, formKey.currentState.validate());
  });

  testWidgets("Test campo data", (WidgetTester tester) async {
    await tester.pumpWidget(getApp());

    Form form = tester.widget(find.byType(Form));
    GlobalKey<FormState> formKey = form.key;
    // Formulário válido
    await tester.enterText(find.byKey(Key("txtTitle")), "Title exemple");
    await tester.enterText(
        find.byKey(Key("txtDescription")), "Description exemple");
    await tester.enterText(find.byKey(Key("txtDateStart")), "16/02/2020");
    await tester.enterText(find.byKey(Key("txtDateEnd")), "20/02/2020");
    expect(true, formKey.currentState.validate());

    // Data inválida
    await tester.enterText(find.byKey(Key("txtDateEnd")), "30/02/2020");
    expect(false, formKey.currentState.validate());
    await tester.enterText(find.byKey(Key("txtDateStart")), "30/02/2020");
    expect(false, formKey.currentState.validate());

    // Prazo inválido
    await tester.enterText(find.byKey(Key("txtDateStart")), "20/02/2020");
    await tester.enterText(find.byKey(Key("txtDateEnd")), "01/02/2020");
    expect(false, formKey.currentState.validate());
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/view/todoNewPage.dart';

MediaQuery getApp() {
  return new MediaQuery(
      data: new MediaQueryData(), child: new MaterialApp(home: TodoNewPage()));
}

void main() {
  testWidgets("Teste campo em branco", (tester) async {
    // prepara app
    await tester.pumpWidget(getApp());

    Form form = tester.widget(find.byType(Form));
    GlobalKey<FormState> formKey = form.key;
    expect(false, formKey.currentState.validate());

    // preenche campos
    await tester.enterText(find.byKey(Key("txtTitle")), "Title exemple");
    expect(false, formKey.currentState.validate());

    await tester.enterText(
        find.byKey(Key("txtDescription")), "Description exemple");
    expect(false, formKey.currentState.validate());

    await tester.enterText(find.byKey(Key("txtDateStart")), "16/02/2020");
    expect(false, formKey.currentState.validate());

    await tester.enterText(find.byKey(Key("txtDateEnd")), "20/02/2020");
    expect(true, formKey.currentState.validate());
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

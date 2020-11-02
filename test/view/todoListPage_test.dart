import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas/view/homePage.dart';
import 'package:lista_de_tarefas/view/todoNewPage.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets("Navigation Add todo test", (tester) async {
    final mockObserver = MockNavigatorObserver();
    var app = MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
          home: HomePage(),
          navigatorObservers: [mockObserver],
        ));
    await tester.pumpWidget(app);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // tap FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // verifica ação de toque foi executada
    verify(mockObserver.didPush(any, any));

    // Verifica a existencia de TarefaAddPage na árvore de widget
    expect(find.byType(TodoNewPage), findsOneWidget);
  });
}

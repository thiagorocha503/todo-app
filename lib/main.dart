import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lista_de_tarefa/view/tarefaListPage.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('en', 'US'),
                         const Locale('pt', 'BR'),
                         const Locale('es')],                
      debugShowCheckedModeBanner: false,
      home: TarefaListPage()
      )
    );
}

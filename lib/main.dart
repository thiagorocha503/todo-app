import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lista_de_tarefas/view/homePage.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Lista de tarefas",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
        const Locale('pt', 'PT'),
        const Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

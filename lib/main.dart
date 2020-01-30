
import 'package:flutter/material.dart';
import 'package:lista_de_tarefa/view/tarefaListPage.dart';



void main(){
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
     debugShowCheckedModeBanner: false,
      home: TarefaListPage()
    )
  );
}
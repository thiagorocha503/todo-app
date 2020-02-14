import 'package:flutter/material.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/presenter/tarefaAddPresenter.dart';
import 'package:lista_de_tarefa/util/dateConversion.dart';
import 'package:lista_de_tarefa/util/validation.dart';
import 'package:lista_de_tarefa/view/view.dart';


class TarefaAddPage extends StatefulWidget {
  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<TarefaAddPage> implements IPageNewNote {
  bool _checkDone = false;
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtDescription = new TextEditingController();
  TextEditingController _txtDataStart = new TextEditingController();
  TextEditingController _txtDateEnd = new TextEditingController();
  DateTime dateStartSelected = new DateTime.now();
  DateTime dateEndSelected = new DateTime.now();
  final _formKey = GlobalKey<FormState>();
  BuildContext scaffoldContext;
  List prioridades = ["Normal", "Baixa", "Alta"];
  String prioridadeSelected = "Normal";
  IPresenterTarefaAdd presenter;
  
 
 

  @override
  void onCadastro() {
   Map note = { 
     "title":this._txtTitle.text,
     "description":this._txtDescription.text,
      "dateStart": this._txtDataStart.text,
      "dateEnd":this._txtDateEnd.text,
      "priority": this.getPrioridadeAsInt(this.prioridadeSelected),
      "done":this._checkDone
   };
   debugPrint(note.toString());
   this.presenter.noteInsert(note);
  }

  @override
  void initState(){
    super.initState();
    this.presenter = new TarefaAddPresenter();
    this.presenter.setView(this);
  

  }
  void showSnackBarInfo(String message){
  final SnackBar snackBarInfo = new SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
    
            );
     Scaffold.of(this.scaffoldContext).showSnackBar(snackBarInfo);

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Nova tarefa"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.check, color: Colors.white),
                  tooltip: "Salvar",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      this.onCadastro();  
                    }
                  })
            ],
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  this.backPage();
                },
              );
            }),
          ),
          body:SafeArea(
            child: Builder(builder: (context) {
            this.scaffoldContext = context;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Preencha o campo titulo";
                          }
                          return null;
                        },
                        controller: this._txtTitle,
                        decoration: InputDecoration(
                            labelText: "Título", border: OutlineInputBorder()),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: TextFormField(
                        maxLines: 10,
                        controller: this._txtDescription,
                        decoration: InputDecoration(
                            labelText: "Descrição",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Preencha o campo descrição";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: TextFormField(
                                controller: this._txtDataStart,
                                decoration: InputDecoration(
                                    labelText: "Data de ínicio",
                                    hintText: "00/00/0000",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Preencha o campo data de ínicio";
                                  }
                                  if (!Validation.isDateValida(value)){
                                    return "Data inválida";
                                  }
                                  return null;
                                },
                              )),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color:Theme.of(context).primaryColor,),
                              onPressed: () {
                                setState(() {
                                  this._selectDateStart(context);
                                });
                              },
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: TextFormField(
                                controller: this._txtDateEnd,
                                decoration: InputDecoration(
                                    labelText: "Data de término",
                                    hintText: "00/00/0000",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Preencha o campo data de término";
                                  }
                                  if(!Validation.isDateValida(value)){
                                    return "Data inválida";
                                  }
                                  if(Validation.isDateValida(this._txtDataStart.text)){
                                    DateTime dateStart = DateConversion.dateFormtToDateTime(this._txtDataStart.text);
                                    DateTime dateEnd = DateConversion.dateFormtToDateTime(this._txtDateEnd.text);
                                    if(dateEnd.compareTo(dateStart) < 0){
                                      return "Data anterior a data de ínicio";
                                    }
                                  }
                                  return null;
                                },
                              )),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  this._selectDateEnd(context);
                                });
                              },
                            )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: DropdownButton(
                          isExpanded: true,
                          value: this.prioridadeSelected,
                          items: this.prioridades.map((dropDownValue) {
                            return DropdownMenuItem<String>(
                                value: dropDownValue,
                                child: Text(dropDownValue));
                          }).toList(),
                          onChanged: (newValue) {
                            this.onDropDownItemSelected(newValue);
                          }),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: Text(
                            "Concluido",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Checkbox(
                            value: this._checkDone,
                            onChanged: (newValue) {
                              setState(() {
                                this._checkDone = newValue;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  void backPage(){
    Navigator.pop(context);
  }
 
  @override
  void onDropDownItemSelected(String newValue) {
    setState(() {
      this.prioridadeSelected = newValue;
    });
  }

  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateStartSelected,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateStartSelected)
      setState(() {
        this.dateStartSelected = picked;
        this._txtDataStart.text = DateConversion.dateTimeToDateFormt(picked);
      });
  }

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateEndSelected,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateEndSelected)
      setState(() {
        this.dateEndSelected = picked;
        this._txtDateEnd.text = DateConversion.dateTimeToDateFormt(picked);
      });
  }
  
  @override
  void showSnackBarMessage(String message) {
    SnackBar snackbar = SnackBar(content: Text(message));
    Scaffold.of(this.scaffoldContext).showSnackBar(snackbar);
  }
  
  @override
  void cleanField() {
    setState(() {
      this._txtTitle.text = "";
      this._txtDescription.text = "";
      this._txtDataStart.text = "";
      this._txtDateEnd.text = "";
      this._checkDone = false;
    });
  }

  int getPrioridadeAsInt(String prioridade){
    switch(prioridade){
      case "Alta":
        return 1;
      case "Normal":
        return 2;
      case "Baixa":
        return 3;
      default:
        return 0;
    }
  }

  
}

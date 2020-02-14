import 'package:flutter/material.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/presenter/tarefaEditPresenter.dart';
import 'package:lista_de_tarefa/util/DateConversion.dart';
import 'package:lista_de_tarefa/view/view.dart';
import 'package:lista_de_tarefa/util/validation.dart';

class TarefaEditPage extends StatefulWidget {
  final Map note;

  TarefaEditPage({Key key, @required this.note}) : super(key: key);
  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<TarefaEditPage> implements INoteEdit {
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
  IEditPresenter presenter;

  @override
  void onClickUpdate() {
    Map note = {
      "id": widget.note["id"],
      "title": this._txtTitle.text,
      "description": this._txtDescription.text,
      "dateStart": this._txtDataStart.text,
      "dateEnd": this._txtDateEnd.text,
      "priority": this.getPrioridadeAsInt(this.prioridadeSelected),
      "done": this._checkDone
    };
    debugPrint(note.toString());
    this.presenter.updateNote(note);
  }

  void _showDialogDelete() {
    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Remoção",
            ),
            content: Text(
              "Confirmar exclusão?",
            ),
            actions: <Widget>[
              OutlineButton(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Excluir",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    this.presenter.delete(widget.note["id"]);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  void onClickDelete() {
    this._showDialogDelete();
  }

  @override
  void setField() {
    debugPrint(widget.note.toString());
    this._txtTitle.text = widget.note["title"];
    this._txtDescription.text = widget.note["description"];
    this._txtDataStart.text = widget.note["dateStart"];
    this._txtDateEnd.text = widget.note["dateEnd"];
    this._checkDone = widget.note["done"];
    this.prioridadeSelected =
        this.getPrioridadeAsString(widget.note["priority"]);
  }

  @override
  void initState() {
    super.initState();
    this.presenter = new NoteEditPresenter();
    this.presenter.setView(this);
    this.setField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar tarefa"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save, color: Colors.white),
              tooltip: "Salvar",
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  this.onClickUpdate();
                }
              }),
          IconButton(
              icon: Icon(Icons.delete),
              tooltip: "Remover",
              onPressed: () {
                this.onClickDelete();
              }),
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
      body: SafeArea(child: Builder(builder: (context) {
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
                        labelText: "Descrição", border: OutlineInputBorder()),
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
                                hintText: "00/00/0000",
                                labelText: "Data de ínicio",
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Preencha o campo data de ínicio";
                              }
                              if (!Validation.isDateValida(value)) {
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
                              color: Theme.of(context).primaryColor),
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
                                hintText: "00/00/0000",
                                labelText: "Data de término",
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Preencha o campo data de término";
                              }
                              if (!Validation.isDateValida(value)) {
                                return "Data inválida";
                              }
                              if (Validation.isDateValida(
                                  this._txtDataStart.text)) {
                                DateTime dateStart =
                                    DateConversion.dateFormtToDateTime(
                                        this._txtDataStart.text);
                                DateTime dateEnd =
                                    DateConversion.dateFormtToDateTime(
                                        this._txtDateEnd.text);
                                if (dateEnd.compareTo(dateStart) < 0) {
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
                            value: dropDownValue, child: Text(dropDownValue));
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

  String getPrioridadeAsString(int prioridade) {
    if (prioridade == 1) {
      return "Alta";
    } else if (prioridade == 2) {
      return "Normal";
    } else {
      return "Baixa";
    }
  }

  int getPrioridadeAsInt(String prioridade) {
    switch (prioridade) {
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

  @override
  void backPage() {
    Navigator.pop(context);
  }
}

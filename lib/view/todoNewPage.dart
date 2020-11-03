import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/presenter/todoAddPresenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class TodoNewPage extends StatefulWidget {
  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<TodoNewPage> implements IPageNewTodo {
  bool _checkDone = false;
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtDescription = new TextEditingController();
  TextEditingController _txtDueDate = new TextEditingController();
  DateTime dueDateSelected = new DateTime.now();
  bool _isSelectedDueDate = false;
  final _formKey = GlobalKey<FormState>();
  BuildContext scaffoldContext;
  List prioridades = ["Normal", "Baixa", "Alta"];
  String prioridadeSelected = "Normal";
  ITodoAddPresenter presenter;

  @override
  void onCadastro() {
    DateTime today = DateTime.now();
    Map json = {
      "id": 0,
      "title": this._txtTitle.text,
      "description": this._txtDescription.text,
      "created_date": today,
      "due_date": this.dueDateSelected,
      "complete_date": this._checkDone ? today : null,
      "priority": this.getPrioridadeAsInt(this.prioridadeSelected),
      "done": this._checkDone,
    };
    debugPrint(json.toString());
    this.presenter.todoInsert(json);
  }

  @override
  void initState() {
    super.initState();
    this.presenter = new TarefaAddPresenter();
    this.presenter.setView(this);
  }

  void showSnackBarInfo(String message) {
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
            key: Key("buttonCheck"),
            icon: Icon(Icons.check, color: Colors.white),
            tooltip: "Salvar",
            onPressed: () {
              if (_formKey.currentState.validate()) {
                this.onCadastro();
              }
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              key: Key("backPage"),
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                this.backPage();
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            this.scaffoldContext = context;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
                        child: TextFormField(
                          key: Key("txtTitle"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preencha o campo título";
                            }
                            return null;
                          },
                          controller: this._txtTitle,
                          decoration: InputDecoration(
                            labelText: "Título",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                          key: Key("txtDescription"),
                          maxLines: 10,
                          controller: this._txtDescription,
                          decoration: InputDecoration(
                            helperText: "Opcional",
                            labelText: "Descrição",
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                          controller: this._txtDueDate,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          onTap: () {
                            debugPrint("Tap date picker");
                            this._selectDueDate(context);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data para concluir",
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.calendar_today),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preencha o campo data para concluir";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: DropdownButtonFormField<String>(
                          key: Key("dropPriority"),
                          decoration: const InputDecoration(
                            border: const OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          value: this.prioridadeSelected,
                          items: this.prioridades.map((dropDownValue) {
                            return DropdownMenuItem<String>(
                              value: dropDownValue,
                              child: Text(dropDownValue),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            this.onDropDownItemSelected(newValue);
                          },
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Checkbox(
                              key: Key("checkDone"),
                              value: this._checkDone,
                              onChanged: (value) {
                                setState(() {
                                  this._checkDone = value;
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (this._checkDone) {
                                  this._checkDone = false;
                                } else {
                                  this._checkDone = true;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 15, 5),
                              child: Text(
                                "Concluído",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void backPage() {
    Navigator.pop(context);
  }

  @override
  void onDropDownItemSelected(String newValue) {
    setState(() {
      this.prioridadeSelected = newValue;
    });
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final today = new DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this.dueDateSelected,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime.now().add(new Duration(days: 360 * 2)),
    );
    if (picked != null && picked != dueDateSelected) {
      if (!this._isSelectedDueDate) {
        this._isSelectedDueDate = true;
      }
      setState(() {
        this.dueDateSelected = picked;
        DateFormat formatter =
            new DateFormat.yMEd(Localizations.localeOf(context).toString());
        this._txtDueDate.text = formatter.format(picked);
      });
    }
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
      this._txtDueDate.text = "";
      this._checkDone = false;

      dueDateSelected = new DateTime.now();
      this._isSelectedDueDate = false;
      this.prioridadeSelected = "Normal";
    });
  }

  int getPrioridadeAsInt(String prioridade) {
    switch (prioridade) {
      case "Alta":
        return 0;
      case "Normal":
        return 1;
      case "Baixa":
        return 2;
      default:
        return -1;
    }
  }
}

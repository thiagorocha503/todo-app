import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/presenter/tarefaEditPresenter.dart';
import 'package:lista_de_tarefas/view/view.dart';

class TarefaEditPage extends StatefulWidget {
  final Map todo;

  TarefaEditPage({Key key, @required this.todo}) : super(key: key);
  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<TarefaEditPage> implements ITodoEdit {
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
  ITodoEditPresenter presenter;

  bool _isSelectedDateEnd = false;

  bool _isSelectedDateStart = false;

  @override
  void setField() {
    debugPrint(widget.todo.toString());
    this.dateStartSelected = DateTime.parse(widget.todo["dateStart"]);
    this.dateEndSelected = DateTime.parse(widget.todo["dateEnd"]);

    this._txtTitle.text = widget.todo["title"];
    this._txtDescription.text = widget.todo["description"];
    this._txtDataStart.text =
        "${this.dateStartSelected.day.toString().padLeft(2, "0")}/${this.dateStartSelected.month.toString().padLeft(2, '0')}/${this.dateStartSelected.year.toString().padLeft(4, '4')}";
    this._txtDateEnd.text =
        "${this.dateEndSelected.day.toString().padLeft(2, "0")}/${this.dateEndSelected.month.toString().padLeft(2, '0')}/${this.dateEndSelected.year.toString().padLeft(4, '4')}";
    this._checkDone = widget.todo["done"];
    this.prioridadeSelected =
        this.getPrioridadeAsString(widget.todo["priority"]);
  }

  @override
  void initState() {
    super.initState();
    this.presenter = new NoteEditPresenter();
    this.presenter.setView(this);
    debugPrint("${widget.todo}");
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
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: "Remover",
            onPressed: () {
              this.onClickDelete();
            },
          ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              this.scaffoldContext = context;
              return Form(
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
                          controller: this._txtDataStart,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          onTap: () {
                            debugPrint("Tap date picker");
                            this._selectDateStart(context);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data de ínicio",
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_today,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preencha este campo";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                          controller: this._txtDateEnd,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          onTap: () {
                            debugPrint("Tap date picker");
                            this._selectDateEnd(context);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data de término",
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_today,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preencha este campo";
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
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void onClickUpdate() {
    Map todo = {
      "id": widget.todo["id"],
      "title": this._txtTitle.text,
      "description": this._txtDescription.text,
      "dateStart": this.dateStartSelected,
      "dateEnd": this.dateEndSelected,
      "priority": this.getPrioridadeAsInt(this.prioridadeSelected),
      "done": this._checkDone
    };
    debugPrint(todo.toString());
    this.presenter.updateTodo(todo);
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
            "Excluir tarefa?",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancelar".toUpperCase(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Excluir".toUpperCase(),
              ),
              onPressed: () {
                this.presenter.delete(widget.todo["id"]);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onClickDelete() {
    this._showDialogDelete();
  }

  @override
  void onDropDownItemSelected(String value) {
    setState(() {
      this.prioridadeSelected = value;
    });
  }

  Future<void> _selectDateStart(BuildContext context) async {
    final start = DateTime.parse(widget.todo["dateStart"]);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this.dateStartSelected,
      firstDate: DateTime(start.year, start.month, start.day),
      lastDate: start.add(new Duration(days: 360 * 2)),
    );
    if (picked != null && picked != dateStartSelected) {
      if (!this._isSelectedDateStart) {
        this._isSelectedDateStart = true;
      }
      setState(() {
        this.dateStartSelected = picked;
        this._txtDataStart.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().padLeft(4, '0')}";
      });
    }
  }

  Future<void> _selectDateEnd(BuildContext context) async {
    final today = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this.dateEndSelected,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime.now().add(new Duration(days: 360 * 2)),
    );
    if (picked != null && picked != dateEndSelected) {
      if (!this._isSelectedDateEnd) {
        this._isSelectedDateEnd = true;
      }
      setState(() {
        this.dateEndSelected = picked;
        this._txtDateEnd.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().padLeft(4, '0')}";
      });
    }
  }

  @override
  void showSnackBarMessage(String message) {
    SnackBar snackbar = SnackBar(content: Text(message));
    Scaffold.of(this.scaffoldContext).showSnackBar(snackbar);
  }

  String getPrioridadeAsString(int prioridade) {
    if (prioridade == 0) {
      return "Alta";
    } else if (prioridade == 1) {
      return "Normal";
    } else if (prioridade == 2) {
      return "Baixa";
    } else {
      return "";
    }
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

  @override
  void backPage() {
    Navigator.pop(context);
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/presenter/aboutPage.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/presenter/tarefaListPresenter.dart';
import 'package:lista_de_tarefas/view/tarefaEditPage.dart';
import 'package:lista_de_tarefas/view/tarefaNewPage.dart';
import 'package:lista_de_tarefas/view/tarefaSearchPage.dart';
import 'package:lista_de_tarefas/view/view.dart';

class TarefaListPage extends StatefulWidget {
  @override
  _TarefaListPageState createState() => _TarefaListPageState();
}

class _TarefaListPageState extends State<TarefaListPage> implements IPageList {
  List<Map> notes;
  BuildContext scaffoldContext;
  IPresenterNoteList presenter;
  static Key floatingActionButtonKey = Key("floatingActionButtonKey");

  int _filterSelected = FILTER_NOT_DONE;
  static const int FILTER_NOT_DONE = 1;
  static const int FILTER_DONE = 2;
  static const int FILTER_ALL = 3;

  static const int MORE_OPTION = 0;
  List<String> suggestions;

  void initList() async {
    notes = new List<Map>();
    await this.presenter.fetchAll(this._filterSelected).then((onValue) {
      setState(() {
        notes = onValue;
      });
    });
  }

  @override
  void onClickIconButtonSearch() {
    showSearch(
      context: context,
      delegate: TarefaSearchPage(this.suggestions),
    ).then((value) {
      if (value["suggestions"] is List<String>) {
        this.suggestions = value["suggestions"];
      }
    }).whenComplete(() {
      this.onRefresh();
    });
  }

  @override
  void initState() {
    super.initState();
    this.presenter = new TarefaListPresent();
    this.presenter.setView(this);
    this.suggestions = [];
    this.initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
        actions: <Widget>[
          IconButton(
            key: Key("buttonSearch"),
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: "Pesquisar",
            onPressed: () {
              this.onClickIconButtonSearch();
            },
          ),
          PopupMenuButton(
            offset: Offset(1.0, 4),
            tooltip: "Filtrar",
            icon: Icon(Icons.filter_list),
            onSelected: (newValue) {
              setState(() {
                this._filterSelected = newValue;
                this.onRefresh();
              });
            },
            //initialValue: this._filterSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: FILTER_NOT_DONE,
                  child: Text(
                    this.getFilterAsString(FILTER_NOT_DONE),
                  ),
                ),
                PopupMenuItem(
                  value: FILTER_DONE,
                  child: Text(
                    this.getFilterAsString(FILTER_DONE),
                  ),
                ),
                PopupMenuItem(
                  value: FILTER_ALL,
                  child: Text(
                    this.getFilterAsString(FILTER_ALL),
                  ),
                )
              ];
            },
          ),
          PopupMenuButton(
            offset: Offset(1.0, 4),
            tooltip: "Mais",
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == MORE_OPTION) {
                this.onAbout();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: MORE_OPTION,
                  child: Text("Sobre"),
                ),
              ];
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          this.scaffoldContext = context;
          return Column(
            children: <Widget>[
              Expanded(
                child: this.buildList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: floatingActionButtonKey,
        onPressed: this.onClickFloatingButton,
        child: Icon(Icons.add),
        tooltip: "Adicionar tarefa",
      ),
    );
  }

  String getFilterAsString(int filter) {
    switch (filter) {
      case FILTER_NOT_DONE:
        return "Não concluidos";
      case FILTER_DONE:
        return "Concluído";
      case FILTER_ALL:
        return "Todos";
      default:
        return "filtro ínvalido";
    }
  }

  void showSnackBarInfo(String message) {
    final SnackBar snackBarInfo = new SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
    Scaffold.of(this.scaffoldContext).showSnackBar(snackBarInfo);
  }

  Color getItemListColor(int index) {
    // caso concluído
    if (this.notes[index]["done"]) {
      return Colors.grey[300];
    }
    // caso atrasado
    DateTime dateEnd = DateTime.parse(this.notes[index]["dateEnd"]);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    if (dateEnd.compareTo(today) < 0) {
      return Colors.red[200];
    }
    return Colors.white;
  }

  Widget getItemListTitle(int index) {
    if (this.notes[index]['done']) {
      return Text(
        this.notes[index]['title'],
        style: TextStyle(
          color: Colors.grey,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text("${this.notes[index]['title']}");
    }
  }

  Widget builderItemList(int index) {
    return Card(
      color: this.getItemListColor(index),
      child: ListTile(
        onTap: () {
          this.onTapListItem(index);
        },
        leading: Checkbox(
          value: this.notes[index]["done"],
          onChanged: (value) {
            setState(() {
              this.notes[index]["done"] = value;
              this.onChangedCheckButton(value, index);
            });
          },
        ),
        trailing: IconButton(
          tooltip: "Remover",
          icon: Icon(Icons.delete),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            this.onClickDelete(index);
          },
        ),
        title: this.getItemListTitle(index),
        subtitle: Text(
          this.notes[index]["description"].toString(),
        ),
      ),
    );
  }

  void onTapListItem(int index) {
    Route rota = new MaterialPageRoute(
      builder: (context) => TarefaEditPage(
        note: this.notes[index],
      ),
    );
    Navigator.push(context, rota).whenComplete(() {
      this.onRefresh();
    });
  }

  Widget buildList() {
    if (this.notes.length == 0) {
      return Center(
        child: Text(
          "Nenhuma tarefa",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: this.notes.length,
      itemBuilder: (context, index) {
        return builderItemList(index);
      },
    );
  }

  @override
  Future<void> onRefresh() async {
    this.presenter.refresh(this._filterSelected);
  }

  @override
  void onClickDelete(int index) async {
    this.presenter.deleteNote(this.notes[index]["id"]);
  }

  @override
  void onChangedCheckButton(bool value, int index) {
    this.presenter.markNote(this.notes[index]["id"], value);
    this.onRefresh();
  }

  @override
  void onClickFloatingButton() async {
    Route rota = new MaterialPageRoute(
      builder: (context) => TarefaAddPage(),
    );
    Navigator.push(context, rota).whenComplete(() {
      this.onRefresh();
    });
  }

  @override
  void updateList(List<Map> newNote) {
    setState(() {
      this.notes = newNote;
    });
  }

  @override
  void onAbout() {
    this.presenter.about();
  }

  @override
  void showAboutPage() {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return AboutPage();
    });
    Navigator.push(context, route);
  }
}

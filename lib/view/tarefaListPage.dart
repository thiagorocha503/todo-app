import 'package:flutter/material.dart';
import 'package:lista_de_tarefa/presenter/presenter.dart';
import 'package:lista_de_tarefa/presenter/tarefaListPresenter.dart';
import 'package:lista_de_tarefa/view/tarefaEditPage.dart';
import 'package:lista_de_tarefa/view/tarefaNewPage.dart';
import 'package:lista_de_tarefa/view/tarefaSearchPage.dart';
import 'package:lista_de_tarefa/view/view.dart';

class TarefaListPage extends StatefulWidget {
  @override
  _TarefaListPageState createState() => _TarefaListPageState();
}

class _TarefaListPageState extends State<TarefaListPage> implements IPageList {
  List<Map> notes;
  Map lastNoteRemoved;
  BuildContext scaffoldContext;
  IPresenterNoteList presenter;

  int _filterSelected = FILTER_NOT_DONE;

  static const int FILTER_NOT_DONE = 1;
  static const int FILTER_DONE = 2;
  static const int FILTER_ALL = 3;

  void initList() async {
    notes = new List<Map>();
    await this.presenter.fetchAll().then((onValue) {
      setState(() {
        notes = onValue;
      });
    });
  }

  @override
  void onClickIconButtonSearch() {
    showSearch(context: context, delegate: TarefaSearchPage()).then((onValue) {
      if(onValue != null){
        Route route = new MaterialPageRoute(builder: (context) =>TarefaEditPage(note: onValue));
        Navigator.push(this.scaffoldContext, route);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.presenter = new TarefaListPresent();
    this.presenter.setView(this);
    this.initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Tarefa"),
        leading: IconButton(
            icon: Icon(Icons.dehaze,
                color: Theme.of(context).secondaryHeaderColor),
            onPressed: null),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              this.onClickIconButtonSearch();
            },
          ),
           PopupMenuButton(
            tooltip: "Filtrar",
            icon: Icon(Icons.filter_list),
            onSelected: (newValue) {
              setState(() {
                this._filterSelected = newValue;
                print("> $newValue");
              });
            },
            initialValue: this._filterSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: FILTER_NOT_DONE,
                  child: Text(this.getFilterAsString(FILTER_NOT_DONE)),
                ),
                PopupMenuItem(
                  value: FILTER_DONE,
                  child: Text(this.getFilterAsString(FILTER_DONE)),
                ),
                PopupMenuItem(
                    value: FILTER_ALL,
                    child: Text(this.getFilterAsString(FILTER_ALL)))
              ];
            }),
        ],
      ),
      body: Builder(builder: (context) {
        this.scaffoldContext = context;
        return Column(
          children: <Widget>[Expanded(child: this.buildList())],
        );
      }),
      floatingActionButton: FloatingActionButton(
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
        return "filtro invalid";
    }
   }
  
  void showSnackBarInfo(String message) {
    final SnackBar snackBarInfo = new SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
    Scaffold.of(this.scaffoldContext).showSnackBar(snackBarInfo);
  }

  @override
  void showSnackBarUndo(String title) {
    final SnackBar undoRemove = new SnackBar(
        content: Text("Tarefa $title removido"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: "desfazer",
            onPressed: () {
              setState(() {
                notes.add(this.lastNoteRemoved);
              });
            }));
    Scaffold.of(this.scaffoldContext).showSnackBar(undoRemove);
  }

  Widget builderItemList(int index) {
    return Card(
        child: ListTile(
      onTap: () {
        this.onTapListItem(index);
      },
      leading: Checkbox(
          value: this.notes[index]["done"],
          onChanged: (value) {
            setState(() {
              this.onChangedCheckButton(value, index);
            });
          }),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          this.onClickDelete(index);
        },
      ),
      title: Text(this.notes[index]["title"].toString()),
      subtitle: Text(this.notes[index]["description"].toString()),
    ));
  }

  void onTapListItem(int index) {
    Route rota = new MaterialPageRoute(
      builder: (context) => TarefaEditPage(note: this.notes[index]),
    );
    Navigator.push(context, rota);
    this.onRefresh();
  }

  Widget buildList() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: this.notes.length,
        itemBuilder: (context, index) {
          return builderItemList(index);
        },
      ),
    );
  }

  Future<void> onRefresh() async {
    List<Map> newNote = await this.presenter.fetchAll();
    setState(() {
      this.notes = newNote;
      if (notes.length == 0) {
        this.showSnackBarInfo("Nehuma tarefa");
      }
    });
  }

  @override
  void onClickDelete(int index) async {
    String title = this.notes[index]["title"];
    this.lastNoteRemoved = this.notes[index];
    this.presenter.deleteNote(this.notes[index]["id"]);
    this.onRefresh();
    this.showSnackBarUndo(title);
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
    Navigator.push(context, rota);
    this.onRefresh();
  }

  @override
  void updateList(List<Map> notes) {
    setState(() {
      this.notes = notes;
    });
  }
}

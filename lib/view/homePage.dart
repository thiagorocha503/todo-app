import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/view/aboutPage.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/presenter/todoHomePresenter.dart';
import 'package:lista_de_tarefas/view/todoEditPage.dart';
import 'package:lista_de_tarefas/view/todoNewPage.dart';
import 'package:lista_de_tarefas/view/todoSearchPage.dart';
import 'package:lista_de_tarefas/view/view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements IHomePage {
  BuildContext scaffoldContext;
  IHomePresenter presenter;
  static Key floatingActionButtonKey = Key("floatingActionButtonKey");
  int _filterSelected = FILTER_NOT_DONE;
  static const int FILTER_NOT_DONE = 1;
  static const int FILTER_DONE = 2;
  static const int FILTER_ALL = 3;

  static const int MORE_OPTION = 0;
  List<String> suggestions;

  @override
  void onClickIconButtonSearch() {
    showSearch(
      context: context,
      delegate: TodoSearchPage(this.suggestions),
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
    this.presenter = new HomePresent(this);
    this.suggestions = [];
    this.presenter.fetchAll(this._filterSelected);
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
            onSelected: (value) {
              setState(() {
                this._filterSelected = value;
                this.onRefresh();
              });
            },
            initialValue: this._filterSelected,
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
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: MORE_OPTION,
                  child: Text("Sobre"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == MORE_OPTION) {
                this.showAboutPage();
              }
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
                child: StreamBuilder<List<Map<dynamic, dynamic>>>(
                  stream: this.presenter.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return buildList(snapshot.data);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
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

  Color getItemListColor(Map todo) {
    // case done
    if (todo["done"]) {
      return Colors.grey[300];
    }
    // late case
    DateTime dueDate = DateTime.parse(todo["due_date"]);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    if (dueDate.compareTo(today) < 0) {
      return Colors.red[200];
    }
    return Colors.white;
  }

  Widget getItemListTitle(Map todo) {
    if (todo['done']) {
      return Text(
        todo['title'],
        style: TextStyle(
          color: Colors.grey,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text("${todo['title']}");
    }
  }

  Widget builderItemList(Map todo) {
    return Card(
      color: this.getItemListColor(todo),
      child: ListTile(
        onTap: () {
          this.onTapListItem(todo);
        },
        leading: Checkbox(
          value: todo["done"],
          onChanged: (value) {
            setState(() {
              todo["done"] = value;
              this.onChangedCheckButton(todo["id"], value);
            });
          },
        ),
        trailing: IconButton(
          tooltip: "Remover",
          icon: Icon(Icons.delete),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            this.onClickDelete(todo["id"]);
          },
        ),
        title: this.getItemListTitle(todo),
        subtitle: Text(
          todo["description"].toString(),
        ),
      ),
    );
  }

  void onTapListItem(Map todo) {
    Route rota = new MaterialPageRoute(
      builder: (context) => TodoEditPage(
        todo: todo,
      ),
    );
    Navigator.push(context, rota).then((value) {
      if (value["showSuccessDelete"] != null) {
        if (value["showSuccessDelete"]) {
          this.showSnackBarInfo("Tarefa removida");
        }
      }
    }).whenComplete(() {
      this.onRefresh();
    });
  }

  Widget buildList(List<Map> todos) {
    if (todos.length == 0) {
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
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return builderItemList(todos[index]);
      },
    );
  }

  @override
  void onClickDelete(int id) async {
    this.presenter.deleteTodo(id);
  }

  @override
  void onChangedCheckButton(int id, bool value) {
    this.presenter.markTodo(id, value);
    this.onRefresh();
  }

  @override
  void onClickFloatingButton() async {
    Route rota = new MaterialPageRoute(
      builder: (context) => TodoNewPage(),
    );
    Navigator.push(context, rota).whenComplete(() {
      this.onRefresh();
    });
  }

  @override
  void showAboutPage() {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return AboutPage();
    });
    Navigator.push(context, route);
  }

  @override
  void onRefresh() {
    this.presenter.fetchAll(this._filterSelected);
  }

  @override
  void dispose() {
    this.presenter.close();
    super.dispose();
  }
}

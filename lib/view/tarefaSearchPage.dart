import 'package:flutter/material.dart';
import 'package:lista_de_tarefa/presenter/tarefaSearchPresenter.dart';

class TarefaSearchPage extends SearchDelegate<Map> {
  List<Map> notes = new List<Map>();
  Future<List<Map>> futureMap;
  ISearchPresenter presenter;

  TarefaSearchPage() {
    this.presenter = new SearchPresenter();
    futureMap = this.presenter.findByTitle(query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget builListItem(int index, BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          close(context, this.notes[index]);
        },
        leading: Checkbox(
          value: this.notes[index]["done"],
          onChanged: (value) {
            close(context, null);
          },
        ),
        title: Text(this.notes[index]["title"]),
        subtitle: Text(this.notes[index]["description"]),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return this.builListItem(index, context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return new FutureBuilder<List<Map>>(
      future: this.futureMap,
      builder: (context, snapshot) {
        debugPrint("${snapshot.connectionState} ");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            {
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                this.notes = snapshot.data;
                debugPrint("query $query");
                debugPrint("> ${snapshot.data.toString()}");
                return buildList();
              }
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

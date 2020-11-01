import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/presenter/tarefaSearchPresenter.dart';

class TarefaSearchPage extends SearchDelegate<Map> {
  List<Map> notes = new List<Map>();
  ISearchPresenter presenter;

  TarefaSearchPage() {
    this.presenter = new SearchPresenter();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  TextStyle get searchFieldStyle =>
      TextStyle(color: Colors.white, fontSize: 18.0);

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
        onTap: () {
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
      future: this.presenter.findByTitle(query),
      builder: (context, snapshot) {
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
                return buildList();
              }
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new FutureBuilder<List<Map>>(
      future: this.presenter.findByTitle(query),
      builder: (context, snapshot) {
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
                return buildList();
              }
            }
        }
      },
    );
  }
}

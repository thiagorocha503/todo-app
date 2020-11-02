import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/presenter/tarefaSearchPresenter.dart';
import 'package:lista_de_tarefas/view/todoEditPage.dart';

class TodoSearchPage extends SearchDelegate<Map> {
  List<Map> todos = new List<Map>();
  ISearchPresenter presenter;
  List<String> suggestions;

  TodoSearchPage(List<String> suggestions) {
    this.presenter = new SearchPresenter();
    this.suggestions = suggestions == null ? [] : suggestions;
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
        close(context, {"suggestions": this.suggestions});
      },
    );
  }

  Widget builListItem(int index, BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return new TodoEditPage(todo: this.todos[index]);
              },
            ),
          );
        },
        leading: Checkbox(
          value: this.todos[index]["done"],
          onChanged: (value) {
            close(context, null);
          },
        ),
        title: Text(this.todos[index]["title"]),
        subtitle: Text(this.todos[index]["description"]),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return this.builListItem(index, context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (this.query != "" && !this.suggestions.contains(this.query)) {
      this.suggestions.add(this.query);
    }
    if (this.todos.length == 0) {
      return Center(
        child: Text(
          "Nenhum resultado",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return new FutureBuilder<List<Map>>(
      future: this.presenter.findByTitle(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          this.todos = snapshot.data;
          return buildList();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query == "") {
      return ListView.builder(
        itemCount: this.suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              this.query = this.suggestions[index];
            },
            title: Text(this.suggestions[index]),
          );
        },
      );
    }
    return new FutureBuilder<List<Map>>(
      future: this.presenter.findByTitle(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          this.todos = snapshot.data;
          return buildList();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

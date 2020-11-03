import 'dart:convert';
import 'package:lista_de_tarefas/model/todoException.dart';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  static const PRIORITY_HIGH = 0;
  static const PRIORITY_NORMAL = 1;
  static const PRIORITY_LOW = 2;

  Todo({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.dueDate,
    this.completeDate,
    this.priority = Todo.PRIORITY_NORMAL,
    this.done = false,
  });

  int id;
  String title;
  String description;
  DateTime createdDate;
  DateTime dueDate;
  DateTime completeDate;
  int priority;
  bool done;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      createdDate: DateTime.parse(json["created_date"]),
      dueDate: DateTime.parse(json["due_date"]),
      completeDate: json["complete_date"] == null
          ? null
          : DateTime.parse(json["complete_date"]),
      priority: json["priority"],
      done: (json["done"] == 1 ? true : false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "created_date":
          "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
      "due_date":
          "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
      "complete_date": completeDate == null
          ? null
          : "${completeDate.year.toString().padLeft(4, '0')}-${completeDate.month.toString().padLeft(2, '0')}-${completeDate.day.toString().padLeft(2, '0')}",
      "priority": priority,
      "done": (done ? 1 : 0),
    };
  }

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return this.id;
  }

  String getTitle() {
    return this.title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getDescription() {
    return this.description;
  }

  void setDescription(String description) {
    this.description = description;
  }

  DateTime getDateCreated() {
    return this.createdDate;
  }

  void setDateCreated(DateTime date) {
    this.createdDate = date;
  }

  int getPriority() {
    return this.priority;
  }

  void setPriority(int priority) {
    if (priority < 0 || priority > 2) {
      throw new TodoPriorityException(priority);
    }
    this.priority = priority;
  }

  bool getDone() {
    return this.done;
  }

  void setDone(bool done) {
    this.done = done;
  }

  @override
  String toString() {
    return "{id: ${this.id}," +
        "title: ${this.title}, " +
        "description: ${this.description}, " +
        "due_date: ${this.dueDate.year.toString().padLeft(4, '0')}-${this.dueDate.month.toString().padLeft(2, '0')}-${this.dueDate.day.toString().padLeft(2, '0')}, " +
        "priority: ${this.priority}, " +
        "done: ${this.done}";
  }
}

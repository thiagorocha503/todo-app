import 'dart:convert';

Note noteFromJson(String str) => Note.fromMap(json.decode(str));

String noteToJson(Note data) => json.encode(data.toMap());

class Note {
  int id;
  String title;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  int priority;
  bool done;

  Note({
    this.id,
    this.title,
    this.description,
    this.dateStart,
    this.dateEnd,
    this.priority,
    this.done,
  });

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: DateTime.parse(json["date_end"]),
        priority: json["priority"],
        done: (json["done"] == 1) ? true : false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "date_start":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "date_end":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "priority": priority,
        "done": (done) ? 1 : 0,
      };

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

  DateTime getDateStart() {
    return this.dateStart;
  }

  void setDateStart(DateTime date) {
    this.dateStart = date;
  }

  DateTime getDateEnd() {
    return this.dateEnd;
  }

  void setDateEnd(DateTime date) {
    this.dateEnd = date;
  }
  
  int getPriority(){
    return this.priority;
  }

  void setPriority(int priority) {
    this.priority = priority;
  }
  
  bool getDone(){
    return this.done;
  }

  void setDone(bool done) {
    this.done = done;
  }

  @override
  String toString() {
    return "{id: ${this.id}," + 
           "title: ${this.title}, "+
           "description: ${this.description}, "+
           "dataStart: ${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}, "+
           "dataEnd: ${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}, "+
           "priority: ${this.priority}, "+
           "done: ${this.done}}";
  }
}

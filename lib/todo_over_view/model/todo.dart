// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo extends Equatable {
  const Todo({
    this.dueDate,
    this.id = 0,
    required this.name,
    this.note = "",
    this.createdDate,
    this.completeDate,
  });

  final int id;
  final String name;
  final String note;
  final DateTime? createdDate;
  final DateTime? dueDate;
  final DateTime? completeDate;

  Todo copyWith({
    int? id,
    String? name,
    String? note,
    required DateTime? createdDate,
    required DateTime? dueDate,
    required DateTime? completeDate,
  }) =>
      Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        note: note ?? this.note,
        createdDate: createdDate,
        dueDate: dueDate,
        completeDate: completeDate,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      name: json["title"].toString(),
      note: json["note"],
      createdDate: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      dueDate: json["due"] == null ? null : DateTime.parse(json["due"]),
      completeDate: json["complete_at"] == null
          ? null
          : DateTime.parse(json["complete_at"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
        "note": note,
        "created_at": createdDate?.toIso8601String().replaceAll("T", " "),
        "due": dueDate?.toIso8601String().replaceAll("T", " "),
        "complete_at": completeDate?.toIso8601String().replaceAll("T", " "),
      };

  @override
  String toString() {
    return "Todo{id: $id, name: $name, created at: $createdDate due: $dueDate, complete at: $completeDate}";
  }

  @override
  List<Object?> get props => [
        dueDate,
        id,
        name,
        note,
        createdDate,
        completeDate,
      ];
}

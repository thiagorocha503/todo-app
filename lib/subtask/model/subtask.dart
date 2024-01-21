// To parse this JSON data, do
//
//     final subtask = subtaskFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Subtask subtaskFromJson(String str) => Subtask.fromJson(json.decode(str));

String subtaskToJson(Subtask data) => json.encode(data.toJson());

class Subtask extends Equatable {
  const Subtask({
    this.id,
    required this.name,
    required this.complete,
    required this.todoId,
  });

  final int? id;
  final String name;
  final bool complete;
  final int todoId;

  Subtask copyWith({
    int? id,
    String? name,
    bool? complete,
    int? todoId,
  }) =>
      Subtask(
        id: id ?? this.id,
        name: name ?? this.name,
        complete: complete ?? this.complete,
        todoId: todoId ?? this.todoId,
      );

  factory Subtask.fromJson(Map<String, dynamic> json) => Subtask(
        id: json["id"],
        name: json["name"].toString(),
        complete: json["complete"] == 1 ? true : false,
        todoId: json["task_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "complete": complete == true ? 1 : 0,
        "task_id": todoId,
      };

  @override
  String toString() {
    return "Subtask{id: $id, name: $name, complete: $complete, todoId: $todoId}";
  }

  @override
  List<Object?> get props => [id, name, complete, todoId];
}

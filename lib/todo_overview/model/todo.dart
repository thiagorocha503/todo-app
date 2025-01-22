// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:todo/shared/model/wrapped.dart';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo extends Equatable {
  const Todo({
    this.id,
    required this.name,
    this.description = "",
    this.dueDate,
    this.listId,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String name;
  final String description;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int? listId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Todo copyWith({
    Wrapped<int?>? id,
    String? name,
    String? description,
    Wrapped<DateTime?>? dueDate,
    Wrapped<DateTime?>? completedAt,
    Wrapped<int?>? listId,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) =>
      Todo(
        id: id != null ? id.value : this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        dueDate: dueDate != null ? dueDate.value : this.dueDate,
        completedAt: completedAt != null ? completedAt.value : this.completedAt,
        listId: listId != null ? listId.value : this.listId,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      name: json["name"].toString(),
      description: json["description"].toString(),
      dueDate: DateTime.tryParse(json["due_date"] ?? ""),
      completedAt: DateTime.tryParse(json["completed_at"] ?? ""),
      listId: json["list_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "due_date": dueDate?.toIso8601String(),
      "completed_at": completedAt?.toIso8601String(),
      "list_id": listId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String()
    };
  }

  @override
  String toString() {
    return "Todo{id: $id, name: $name, created at: $createdAt due date: $dueDate, complete at: $completedAt}";
  }

  @override
  List<Object?> get props => [
        dueDate,
        id,
        name,
        description,
        createdAt,
        completedAt?.toIso8601String(),
        listId,
        updatedAt?.toIso8601String()
      ];
}

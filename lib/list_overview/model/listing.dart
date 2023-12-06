// To parse this JSON data, do
//
//     final listing = listingFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:todo/shared/model/wrapped.dart';

Listing listingFromMap(String str) => Listing.fromMap(json.decode(str));

String listingToMap(Listing data) => json.encode(data.toMap());

class Listing extends Equatable {
  final int? id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// [count] count of todo in this list
  final int count;

  const Listing({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    required this.count,
  });

  Listing copyWith(
          {Wrapped<int?>? id,
          String? name,
          Wrapped<DateTime?>? createdAt,
          Wrapped<DateTime?>? updatedAt,
          int? count}) =>
      Listing(
        id: id != null ? id.value : this.id,
        name: name ?? this.name,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        count: count ?? this.count,
      );

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      count: json["count"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "count": count
      };

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt?.millisecondsSinceEpoch,
        updatedAt?.millisecondsSinceEpoch,
        count
      ];

  @override
  String toString() {
    return "{id: $id, name: $name}";
  }
}

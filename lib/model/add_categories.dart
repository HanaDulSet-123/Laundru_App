// To parse this JSON data, do
//
//     final addCatagories = addCatagoriesFromJson(jsonString);

import 'dart:convert';

AddCatagories addCatagoriesFromJson(String str) =>
    AddCatagories.fromJson(json.decode(str));

String addCatagoriesToJson(AddCatagories data) => json.encode(data.toJson());

class AddCatagories {
  String message;
  Data data;

  AddCatagories({
    required this.message,
    required this.data,
  });

  factory AddCatagories.fromJson(Map<String, dynamic> json) => AddCatagories(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String name;
  String image;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.name,
    required this.image,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

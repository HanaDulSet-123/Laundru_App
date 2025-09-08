// To parse this JSON data, do
//
//     final getCategories = getCategoriesFromJson(jsonString);

import 'dart:convert';

GetCategories getCategoriesFromJson(String str) =>
    GetCategories.fromJson(json.decode(str));

String getCategoriesToJson(GetCategories data) => json.encode(data.toJson());

class GetCategories {
  String? message;
  List<GetCategoriesData>? data;

  GetCategories({
    this.message,
    this.data,
  });

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetCategoriesData>.from(
                json["data"]!.map((x) => GetCategoriesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetCategoriesData {
  int? id;
  String? name;
  String? imageUrl;

  GetCategoriesData({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory GetCategoriesData.fromJson(Map<String, dynamic> json) =>
      GetCategoriesData(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
      };
}

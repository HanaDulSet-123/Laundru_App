// To parse this JSON data, do
//
//     final modelLayanan = modelLayananFromJson(jsonString);

import 'dart:convert';

ModelLayanan modelLayananFromJson(String str) =>
    ModelLayanan.fromJson(json.decode(str));

String modelLayananToJson(ModelLayanan data) => json.encode(data.toJson());

class ModelLayanan {
  String? message;
  List<ModelLayananData>? data;

  ModelLayanan({
    this.message,
    this.data,
  });

  factory ModelLayanan.fromJson(Map<String, dynamic> json) => ModelLayanan(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ModelLayananData>.from(
                json["data"]!.map((x) => ModelLayananData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ModelLayananData {
  int? id;
  String? name;
  String? waktuPengerjaan;
  Category? category;
  int? price;

  ModelLayananData({
    this.id,
    this.name,
    this.waktuPengerjaan,
    this.category,
    this.price,
  });

  factory ModelLayananData.fromJson(Map<String, dynamic> json) =>
      ModelLayananData(
        id: json["id"],
        name: json["name"],
        waktuPengerjaan: json["waktu_pengerjaan"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "waktu_pengerjaan": waktuPengerjaan,
        "category": category?.toJson(),
      };
}

class Category {
  dynamic id;
  dynamic name;
  dynamic imageUrl;

  Category({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

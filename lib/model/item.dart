// To parse this JSON data, do
//
//     final modelItem = modelItemFromJson(jsonString);

import 'dart:convert';

ModelItem modelItemFromJson(String str) => ModelItem.fromJson(json.decode(str));

String modelItemToJson(ModelItem data) => json.encode(data.toJson());

class ModelItem {
  String? message;
  List<ModelItemData>? data;

  ModelItem({
    this.message,
    this.data,
  });

  factory ModelItem.fromJson(Map<String, dynamic> json) => ModelItem(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ModelItemData>.from(
                json["data"]!.map((x) => ModelItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ModelItemData {
  int? id;
  String? name;
  String? price;
  String? categoryId;
  String? serviceTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;
  ServiceType? serviceType;

  ModelItemData({
    this.id,
    this.name,
    this.price,
    this.categoryId,
    this.serviceTypeId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.serviceType,
  });

  factory ModelItemData.fromJson(Map<String, dynamic> json) => ModelItemData(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        categoryId: json["category_id"],
        serviceTypeId: json["service_type_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category_id": categoryId,
        "service_type_id": serviceTypeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
        "service_type": serviceType?.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ServiceType {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? waktuPengerjaan;
  dynamic categoryId;

  ServiceType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.waktuPengerjaan,
    this.categoryId,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        waktuPengerjaan: json["waktu_pengerjaan"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "waktu_pengerjaan": waktuPengerjaan,
        "category_id": categoryId,
      };
}

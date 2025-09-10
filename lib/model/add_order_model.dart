import 'dart:convert';

AddOrderModel addOrderModelFromJson(String str) =>
    AddOrderModel.fromJson(json.decode(str));

String addOrderModelToJson(AddOrderModel data) => json.encode(data.toJson());

class AddOrderModel {
  String? message;
  Data? data; // ✅ ubah jadi object tunggal

  AddOrderModel({
    this.message,
    this.data,
  });

  factory AddOrderModel.fromJson(Map<String, dynamic> json) => AddOrderModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? customerId;
  String? layanan;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  List<Item>? items;

  Data({
    this.customerId,
    this.layanan,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: json["customer_id"],
        layanan: json["layanan"],
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "layanan": layanan,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  int? laundryOrderId;
  int? serviceItemId;
  int? quantity;
  int? subtotal;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceItem? serviceItem;

  Item({
    this.id,
    this.laundryOrderId,
    this.serviceItemId,
    this.quantity,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
    this.serviceItem,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        laundryOrderId: json["laundry_order_id"],
        serviceItemId: json["service_item_id"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        serviceItem: json["service_item"] == null
            ? null
            : ServiceItem.fromJson(json["service_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "laundry_order_id": laundryOrderId,
        "service_item_id": serviceItemId,
        "quantity": quantity,
        "subtotal": subtotal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service_item": serviceItem?.toJson(),
      };
}

class ServiceItem {
  int? id;
  String? name;
  int? price;
  int? categoryId;
  int? serviceTypeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceItem({
    this.id,
    this.name,
    this.price,
    this.categoryId,
    this.serviceTypeId,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category_id": categoryId,
        "service_type_id": serviceTypeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final addOrder = addOrderFromJson(jsonString);

import 'dart:convert';

AddOrder addOrderFromJson(String str) => AddOrder.fromJson(json.decode(str));

String addOrderToJson(AddOrder data) => json.encode(data.toJson());

class AddOrder {
  String message;
  DataOrder data;

  AddOrder({
    required this.message,
    required this.data,
  });

  factory AddOrder.fromJson(Map<String, dynamic> json) => AddOrder(
        message: json["message"],
        data: DataOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataOrder {
  int customerId;
  String layanan;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  List<Item> items;

  DataOrder({
    required this.customerId,
    required this.layanan,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.items,
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        customerId: json["customer_id"],
        layanan: json["layanan"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "layanan": layanan,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  int laundryOrderId;
  int serviceItemId;
  int quantity;
  int subtotal;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceItem serviceItem;

  Item({
    required this.id,
    required this.laundryOrderId,
    required this.serviceItemId,
    required this.quantity,
    required this.subtotal,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceItem,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        laundryOrderId: json["laundry_order_id"],
        serviceItemId: json["service_item_id"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        serviceItem: ServiceItem.fromJson(json["service_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "laundry_order_id": laundryOrderId,
        "service_item_id": serviceItemId,
        "quantity": quantity,
        "subtotal": subtotal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service_item": serviceItem.toJson(),
      };
}

class ServiceItem {
  int id;
  String name;
  int price;
  int categoryId;
  int serviceTypeId;
  DateTime createdAt;
  DateTime updatedAt;

  ServiceItem({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.serviceTypeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        categoryId: json["category_id"],
        serviceTypeId: json["service_type_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category_id": categoryId,
        "service_type_id": serviceTypeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

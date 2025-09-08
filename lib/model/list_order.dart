// To parse this JSON data, do
//
//     final listOrder = listOrderFromJson(jsonString);

import 'dart:convert';

ListOrder listOrderFromJson(String str) => ListOrder.fromJson(json.decode(str));

String listOrderToJson(ListOrder data) => json.encode(data.toJson());

class ListOrder {
  String? message;
  List<ListOrders>? data;

  ListOrder({
    this.message,
    this.data,
  });

  factory ListOrder.fromJson(Map<String, dynamic> json) => ListOrder(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ListOrders>.from(
                json["data"]!.map((x) => ListOrders.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListOrders {
  int? id;
  String? customerId;
  String? layanan;
  dynamic serviceTypeId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? total;
  List<Item>? items;

  ListOrders({
    this.id,
    this.customerId,
    this.layanan,
    this.serviceTypeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.total,
    this.items,
  });

  factory ListOrders.fromJson(Map<String, dynamic> json) => ListOrders(
        id: json["id"],
        customerId: json["customer_id"],
        layanan: json["layanan"],
        serviceTypeId: json["service_type_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        total: json["total"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "layanan": layanan,
        "service_type_id": serviceTypeId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total": total,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  String? laundryOrderId;
  String? serviceItemId;
  String? quantity;
  String? subtotal;
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
  String? price;
  String? categoryId;
  String? serviceTypeId;
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

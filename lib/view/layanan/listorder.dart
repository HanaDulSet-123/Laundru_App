// To parse this JSON data, do
//
//     final listOrder = listOrderFromJson(jsonString);

import 'dart:convert';

ListOrder listOrderFromJson(String str) => ListOrder.fromJson(json.decode(str));

String listOrderToJson(ListOrder data) => json.encode(data.toJson());

class ListOrder {
  String message;
  List<Datum> data;

  ListOrder({
    required this.message,
    required this.data,
  });

  factory ListOrder.fromJson(Map<String, dynamic> json) => ListOrder(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int customerId;
  String layanan;
  int? serviceTypeId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceType? serviceType;

  Datum({
    required this.id,
    required this.customerId,
    required this.layanan,
    required this.serviceTypeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerId: json["customer_id"],
        layanan: json["layanan"],
        serviceTypeId: json["service_type_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "layanan": layanan,
        "service_type_id": serviceTypeId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service_type": serviceType?.toJson(),
      };
}

class ServiceType {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  ServiceType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

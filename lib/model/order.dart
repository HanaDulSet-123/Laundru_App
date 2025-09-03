// To parse this JSON data, do
//
//     final detailOrder = detailOrderFromJson(jsonString);

import 'dart:convert';

DetailOrderAPI detailOrderFromJson(String str) =>
    DetailOrderAPI.fromJson(json.decode(str));

String detailOrderToJson(DetailOrderAPI data) => json.encode(data.toJson());

class DetailOrderAPI {
  String message;
  Data data;

  DetailOrderAPI({
    required this.message,
    required this.data,
  });

  factory DetailOrderAPI.fromJson(Map<String, dynamic> json) => DetailOrderAPI(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  int customerId;
  String layanan;
  int serviceTypeId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceType serviceType;

  Data({
    required this.id,
    required this.customerId,
    required this.layanan,
    required this.serviceTypeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        layanan: json["layanan"],
        serviceTypeId: json["service_type_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        serviceType: ServiceType.fromJson(json["service_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "layanan": layanan,
        "service_type_id": serviceTypeId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service_type": serviceType.toJson(),
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

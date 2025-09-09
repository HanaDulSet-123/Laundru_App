import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/add_order.dart';
import 'package:laudry_app/model/item.dart';
import 'package:laudry_app/preference/shared_preference.dart';

class LayananApi {
  static Future<AddOrder> addOrders({
    required String layanan,
    required List<Map<String, dynamic>> items,
    required String status,
  }) async {
    final url = Uri.parse(Endpoint.addorder);
    final response = await http.post(
      url,
      body: {"layanan": layanan, "status": status, "items": items},
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return AddOrder.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  static Future<List<ModelItemData>> getOrder() async {
    final url = Uri.parse(Endpoint.listitem);
    final token = await PreferenceHandler.getToken();

    print("Token: $token");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": token ?? "",
      },
    );
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body)["data"];
      return userJson.map((json) => ModelItemData.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}

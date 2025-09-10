import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/item.dart';
import 'package:laudry_app/model/layanan_model.dart';
import 'package:laudry_app/preference/shared_preference.dart';

class LayananApi {
  static Future<ModelLayanan> getLayanan() async {
    final url = Uri.parse(Endpoint.listlayanan);
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
      return ModelLayanan.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      print("API Error: $error");
      throw Exception(error["message"] ?? "Gagal mengambil profil");
    }
  }

  static Future<List<ModelItemData>> getItem() async {
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

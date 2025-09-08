import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/get_categori.dart';
import 'package:laudry_app/preference/shared_preference.dart';

class CategoriApi {
  static Future<GetCategories> getCategoris() async {
    final url = Uri.parse(Endpoint.categories);
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
      return GetCategories.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      print("API Error: $error");
      throw Exception(error["message"] ?? "Gagal mengambil profil");
    }
  }
}

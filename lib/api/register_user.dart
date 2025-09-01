import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/get_user.dart';
import 'package:laudry_app/model/register_user.dart';
import 'package:laudry_app/preference/shared_preference.dart';

class RegistrationAPI {
  static Future<RegistrasiModel16> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse(Endpoint.register);
    final response = await http.post(
      url,
      body: {"name": name, "email": email, "password": password},
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return RegistrasiModel16.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  static Future<RegistrasiModel16> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(Endpoint.login);
    final response = await http.post(
      url,
      body: {"email": email, "password": password},
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      return RegistrasiModel16.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  static Future<GetUserModel16> updateUser({required String name}) async {
    final url = Uri.parse(Endpoint.profile);
    final token = await PreferenceHandler.getToken();

    final response = await http.put(
      url,
      body: {"name": name},
      headers: {"Accept": "application/json", "Authorization": token ?? ""},
    );
    if (response.statusCode == 200) {
      return GetUserModel16.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Update gagal");
    }
  }

  static Future<GetUserModel16> getProfile() async {
    final url = Uri.parse(Endpoint.profile);
    final token = await PreferenceHandler.getToken();

    print("Token: $token"); // Debug token

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": token ?? "", // Pastikan tidak null
      },
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return GetUserModel16.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      print("API Error: $error");
      throw Exception(error["message"] ?? "Gagal mengambil profil");
    }
  }
}

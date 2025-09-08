import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/register_user.dart';
import 'package:laudry_app/preference/shared_preference.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const id = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  bool isLoading = true;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final token = await PreferenceHandler.getToken();
    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      final response =
          await http.get(Uri.parse("${Endpoint.baseURL}/me"), headers: {
        "Authorization": "Bearer $token",
      });
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        setState(() {
          currentUser = User.fromJson(data);
          isLoading = false;
        });
        await PreferenceHandler.getName();
        await PreferenceHandler.getEmail();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetch profile: $e");
    }
  }

  Future<void> _updateUser() async {
    if (currentUser == null) return;
    final token = await PreferenceHandler.getToken();

    try {
      final response = await http.put(
        Uri.parse("${Endpoint.baseURL}/me/update"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": namaController.text,
          "email": emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil berhasil diperbarui")),
        );
        _fetchUserData(); // refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal update profil")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3338A0),
      ),
      // drawer: buttomnavigation(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentUser == null
              ? Center(child: Text('User tidak ditemukan'))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: EdgeInsets.all(16),
                      color: const Color(0xFF3338A0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // CircleAvatar(
                            //   radius: 40,
                            //   backgroundImage: AssetImage(
                            //     "assets/images/uniform.jpg",
                            //   ),
                            // ),
                            SizedBox(height: 16),
                            Text(
                              currentUser!.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              currentUser!.email,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),

                    // Edit Form
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: namaController
                                ..text = currentUser!.name,
                              decoration: InputDecoration(
                                hintText: 'Nama',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: emailController
                                ..text = currentUser!.email,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _updateUser,
                              child: Text(
                                'Update Profile',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Logout Button
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       PreferenceHandler.removeLogin();
                    //       context.pushReplacement(LoginAPIScreen.id);
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           const Color.fromARGB(255, 94, 86, 85),
                    //     ),
                    //     child: Text(
                    //       "Logout",
                    //       style: TextStyle(
                    //         color: const Color.fromARGB(255, 243, 237, 237),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
    );
  }
}

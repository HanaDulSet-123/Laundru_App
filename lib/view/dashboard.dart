import 'package:flutter/material.dart';
import 'package:laudry_app/api/register_user.dart';
import 'package:laudry_app/model/get_user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<GetUserModel16> _futureUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _futureUser = RegistrationAPI.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: _loadUserData,
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh Data",
          ),
        ],
      ),
      body: FutureBuilder<GetUserModel16>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            final user = snapshot.data!.data!; // asumsi model ada field data
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // ✅ Controller dibuat di sini
                          final nameController = TextEditingController(
                            text: user.name,
                          );
                          final emailController = TextEditingController(
                            text: user.email,
                          );

                          return AlertDialog(
                            title: const Text("Edit Data"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Tutup"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    final updatedUser =
                                        await RegistrationAPI.updateUser(
                                          name: nameController.text,
                                          // kalau API butuh email, tambahin param email
                                        );

                                    setState(() {
                                      _futureUser = Future.value(updatedUser);
                                    });

                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Data berhasil disimpan"),
                                      ),
                                    );
                                  } catch (e) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Gagal update: $e"),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Simpan"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Edit Data"),
                  ),
                  Text(
                    "Nama: ${user.name}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Email: ${user.email}"),
                  const SizedBox(height: 8),
                  Text("ID: ${user.id}"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laudry_app/model/register_user.dart';

class ProfileScreen16 extends StatefulWidget {
  const ProfileScreen16({super.key});
  static const id = "/profile";

  @override
  State<ProfileScreen16> createState() => _ProfileScreen16State();
}

class _ProfileScreen16State extends State<ProfileScreen16> {
  bool isLoading = true;
  User? currentUser;

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentUser();
  // }

  // Future<void> _getCurrentUser() async {
  //   try {
  //     final userName = await PreferenceHandler.getName();

  //     setState(() {
  //       currentUser = User(name: userName, email: userEmail);
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       currentUser = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : currentUser == null
              ? const Center(child: Text('No user data available'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Foto profile
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/image/profile.jpg"),
                      ),

                      const SizedBox(height: 12),

                      // Nama
                      Text(
                        currentUser!.name ?? "No Name",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 4),

                      // Email

                      const SizedBox(height: 12),

                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView(
                          children: const [
                            _ProfileMenu(
                                icon: Icons.local_offer, text: "Offers"),
                            _ProfileMenu(
                                icon: Icons.feedback, text: "Feedback"),
                            _ProfileMenu(icon: Icons.help, text: "Help"),
                            _ProfileMenu(
                                icon: Icons.settings, text: "Platform Service"),
                            _ProfileMenu(icon: Icons.logout, text: "Sign Out"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileMenu({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}

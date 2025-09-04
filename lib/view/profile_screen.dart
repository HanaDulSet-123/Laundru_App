import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(LaundryApp());
}

class LaundryApp extends StatelessWidget {
  const LaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaundryPro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue[800],
          elevation: 1,
        ),
      ),
      home: ProfileScreen16(),
    );
  }
}

class ProfileScreen16 extends StatefulWidget {
  const ProfileScreen16({super.key});

  @override
  _ProfileScreen16State createState() => _ProfileScreen16State();
}

class _ProfileScreen16State extends State<ProfileScreen16> {
  User? _user;
  bool _isLoading = true;
  String _errorMessage = '';

  final String _apiBaseUrl = (Endpoint.baseURL);
  final String _userEndpoint = '$base64Url/profile';
  final String _updateUserEndpoint = '/api/user/update';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token =
          prefs.getString('auth_token'); // Ambil token dari local storage

      if (token == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Anda belum login';
        });
        return;
      }

      final response = await http.get(
        Uri.parse('$_apiBaseUrl$_userEndpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _user = User.fromJson(data['data']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Gagal memuat data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan: $e';
      });
    }
  }

  // Fungsi untuk update data user
  Future<void> _updateUserData(Map<String, dynamic> updatedData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.put(
        Uri.parse('$_apiBaseUrl$_updateUserEndpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        // Refresh data setelah update berhasil
        _fetchUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Gagal memperbarui profil: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (_user != null) {
                _showEditProfileDialog();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _user == null
                  ? Center(child: Text('Data tidak ditemukan'))
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileHeader(),
                          SizedBox(height: 24),
                          _buildContactInfo(),
                          SizedBox(height: 24),
                          _buildAddressSection(),
                          SizedBox(height: 24),
                          _buildMembershipInfo(),
                          SizedBox(height: 24),
                          _buildSettingsMenu(),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _user?.avatarUrl != null ? NetworkImage(_user!.avatarUrl) : null,
          backgroundColor: Colors.grey[300],
          child: _user?.avatarUrl == null ? Icon(Icons.person, size: 40) : null,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _user!.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Member sejak ${_user!.joinDate}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _user!.membership,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informasi Kontak",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildInfoRow(Icons.email, "Email", _user!.email, 'email'),
        SizedBox(height: 8),
        _buildInfoRow(Icons.phone, "Telepon", _user!.phone, 'phone'),
      ],
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, String field) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[700], size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: 18),
          onPressed: () {
            _showEditFieldDialog(field, value);
          },
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Alamat Saya",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                _showAddAddressDialog();
              },
              child: Text("Tambah Alamat"),
            ),
          ],
        ),
        SizedBox(height: 12),
        _user!.addresses.isEmpty
            ? Text("Belum ada alamat yang ditambahkan")
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _user!.addresses.length,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildAddressCard(_user!.addresses[index], index);
                },
              ),
      ],
    );
  }

  Widget _buildAddressCard(Address address, int index) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  address.type,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(width: 8),
                if (address.isPrimary)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Utama",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, size: 18),
                  onPressed: () {
                    _showEditAddressDialog(address, index);
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(address.address),
            SizedBox(height: 4),
            Text(address.district),
            SizedBox(height: 4),
            Text("Kode Pos: ${address.postalCode}"),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipInfo() {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status Membership",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tingkat",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _user!.membership,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Poin Loyalty",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${_user!.points} Poin",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: _user!.points / 1000,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              "${_user!.points} dari 1000 poin menuju level berikutnya",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pengaturan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildMenuOption(Icons.notifications, "Notifikasi", () {}),
        _buildMenuOption(Icons.lock, "Keamanan", () {}),
        _buildMenuOption(Icons.help, "Bantuan", () {}),
        _buildMenuOption(Icons.description, "Syarat & Ketentuan", () {}),
        _buildMenuOption(Icons.exit_to_app, "Keluar", _logout),
      ],
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[700]),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showEditFieldDialog(String field, String currentValue) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${field == 'email' ? 'Email' : 'Telepon'}'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText:
                  'Masukkan ${field == 'email' ? 'email' : 'telepon'} baru',
            ),
            keyboardType: field == 'email'
                ? TextInputType.emailAddress
                : TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Map<String, dynamic> updateData = {field: controller.text};
                  _updateUserData(updateData);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileDialog() {
    TextEditingController nameController =
        TextEditingController(text: _user!.name);
    TextEditingController emailController =
        TextEditingController(text: _user!.email);
    TextEditingController phoneController =
        TextEditingController(text: _user!.phone);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Telepon'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Map<String, dynamic> updateData = {
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                };
                _updateUserData(updateData);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showAddAddressDialog() {
    // Implementasi dialog untuk menambah alamat baru
    // (Butuh form dengan beberapa field: type, address, district, postalCode)
    print('Tambah alamat dialog');
  }

  void _showEditAddressDialog(Address address, int index) {
    // Implementasi dialog untuk mengedit alamat
    print('Edit alamat dialog: $index');
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    // Navigate to login screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

// Model data untuk User
class User {
  final String name;
  final String email;
  final String phone;
  final String joinDate;
  final String membership;
  final int points;
  final String avatarUrl;
  final List<Address> addresses;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.membership,
    required this.points,
    required this.avatarUrl,
    required this.addresses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      joinDate: json['joinDate'] ?? '',
      membership: json['membership'] ?? 'Basic',
      points: json['points'] ?? 0,
      avatarUrl: json['avatarUrl'] ?? '',
      addresses: (json['addresses'] as List? ?? [])
          .map((address) => Address.fromJson(address))
          .toList(),
    );
  }
}

// Model data untuk Address
class Address {
  final String type;
  final String address;
  final String district;
  final String postalCode;
  final bool isPrimary;

  Address({
    required this.type,
    required this.address,
    required this.district,
    required this.postalCode,
    required this.isPrimary,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      district: json['district'] ?? '',
      postalCode: json['postalCode'] ?? '',
      isPrimary: json['isPrimary'] ?? false,
    );
  }
}

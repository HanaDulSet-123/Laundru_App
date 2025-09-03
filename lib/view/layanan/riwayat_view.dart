import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RiwayatPesanan extends StatefulWidget {
  const RiwayatPesanan({super.key});

  @override
  State<RiwayatPesanan> createState() => _RiwayatPesananState();
}

class _RiwayatPesananState extends State<RiwayatPesanan> {
  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final url = Uri.parse("$base64Url/orders");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)["data"];
      return data.map((order) {
        return {
          'id': "ORD${order['id']}",
          'tanggal': order['created_at'].toString().substring(0, 10),
          'layanan': order['layanan'],
          'berat': order['berat'] ?? 0,
          'harga': order['total'] ?? 0,
          'status': order['status'],
          'statusColor': _statusColor(order['status']),
        };
      }).toList();
    } else {
      throw Exception("Gagal ambil pesanan: ${response.body}");
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "selesai":
        return Colors.green;
      case "diproses":
        return Colors.orange;
      case "menunggu":
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada riwayat pesanan",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final riwayat = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: riwayat.length,
            itemBuilder: (context, index) {
              final pesanan = riwayat[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID & Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pesanan['id'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: pesanan['statusColor'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              pesanan['status'],
                              style: TextStyle(
                                color: pesanan['statusColor'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Tanggal
                      Text(
                        pesanan['tanggal'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),

                      // Layanan & Berat
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pesanan['layanan'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("${pesanan['berat']} kg"),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Total Harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Harga",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp ${pesanan['harga']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

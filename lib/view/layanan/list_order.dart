import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laudry_app/api/endpoint/endpoint.dart';
import 'package:laudry_app/model/list_order.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late Future<List<ListOrders>> _orders;

  Future<List<ListOrders>> fetchOrders() async {
    final response = await http.get(
      Uri.parse("${Endpoint.baseURL}/orders"),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final listOrder = ListOrder.fromJson(decoded);
      return listOrder.data ?? [];
    } else {
      throw Exception("Gagal mengambil data pesanan");
    }
  }

  @override
  void initState() {
    super.initState();
    _orders = fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pesanan"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ListOrders>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada pesanan"));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return ExpansionTile(
                title: Text(order.layanan ?? "Tanpa layanan"),
                subtitle: Text("Total: Rp${order.total ?? 0}"),
                children: order.items?.map((item) {
                      return ListTile(
                        leading: const Icon(Icons.check_circle),
                        title: Text(item.serviceItem?.name ?? "Item"),
                        subtitle: Text(
                          "Qty: ${item.quantity} • Rp${item.subtotal}",
                        ),
                      );
                    }).toList() ??
                    [],
              );
            },
          );
        },
      ),
    );
  }
}

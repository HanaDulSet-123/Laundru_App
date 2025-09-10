// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:laudry_app/api/endpoint/endpoint.dart';
// import 'package:laudry_app/model/add_order.dart';

// class OrderListScreen extends StatefulWidget {
//   const OrderListScreen({super.key});

//   @override
//   State<OrderListScreen> createState() => _OrderListScreenState();
// }

// class _OrderListScreenState extends State<OrderListScreen> {
//   late Future<List<AddOrderModel>> _futureOrders;

//   @override
//   void initState() {
//     super.initState();
//     _futureOrders = fetchOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Riwayat Pesanan"),
//       ),
//       body: FutureBuilder<List<AddOrderModel>>(
//         future: _futureOrders,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("Belum ada pesanan"));
//           }

//           final orders = snapshot.data!;
//           return ListView.builder(
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];
//               return ListTile(
//                 title: Text("Pesanan #${order.} - ${order.status}"),
//                 subtitle: Text(
//                   "Total: Rp ${order.total} | ${order.createdAt.toLocal()}",
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:laudry_app/api/endpoint/endpoint.dart';
// import 'package:laudry_app/model/add_order.dart';

// class OrderListScreen extends StatefulWidget {
//   const OrderListScreen({super.key});

//   @override
//   State<OrderListScreen> createState() => _OrderListScreenState();
// }

// class _OrderListScreenState extends State<OrderListScreen> {
//   late Future<List<DataOrder>> _orders;

//   Future<List<DataOrder>> fetchOrders() async {
//     final response = await http.get(
//       Uri.parse("${Endpoint.baseURL}/orders"),
//       // print("https://applaundry.mobileprojp.com/api/orders")
//       headers: {"Accept": "application/json"},
//     );

//     if (response.statusCode == 200) {
//       final decoded = json.decode(response.body);
//       final List data = decoded['data'];
//       return data.map((e) => DataOrder.fromJson(e)).toList();
//     } else {
//       throw Exception("Gagal mengambil data pesanan: ${response.statusCode}");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _orders = fetchOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Riwayat Pesanan")),
//       body: FutureBuilder<List<DataOrder>>(
//         future: _orders,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("Belum ada pesanan"));
//           }

//           final orders = snapshot.data!;
//           return ListView.builder(
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];
//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text("Order #${order.id} • ${order.layanan}"),
//                   subtitle:
//                       Text("Status: ${order.status}\nTotal: Rp${order.total}"),
//                   trailing: const Icon(Icons.chevron_right),
//                   onTap: () {
//                     _showOrderDetail(order);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showOrderDetail(DataOrder order) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Detail Pesanan ${order.id}"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Tanggal: ${order.date}"),
//             Text("Status: ${order.status}"),
//             Text("Layanan: ${order.layanan}"),
//             const SizedBox(height: 10),
//             Text("Items:"),
//             ...order.items.map((item) =>
//                 Text("- ${item.id} x${item.quantity} • Rp${item.subtotal}")),
//             const Divider(),
//             Text("Total: Rp${order.total}"),
//           ],
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Tutup"))
//         ],
//       ),
//     );
//   }
// }

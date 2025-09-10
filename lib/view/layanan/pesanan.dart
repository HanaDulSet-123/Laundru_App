import 'package:flutter/material.dart';
import 'package:laudry_app/api/layananAPI/listorder.dart';
import 'package:laudry_app/api/layananAPI/order_api.dart'; // sesuaikan path
import 'package:laudry_app/model/list_order_model.dart';
import 'package:laudry_app/model/add_order_model.dart';

class PesananPage extends StatefulWidget {
  final int customerId;
  final List<Map<String, dynamic>> items;

  const PesananPage({
    super.key,
    required this.customerId,
    required this.items,
  });

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  late Future<ListOrderModel> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = OrderAPI.getOrders(); // FUTURE sesuai tipe ListOrderModel
  }

  Future<void> _createOrder() async {
    try {
      final AddOrderModel addOrder = await OrderAPI.createOrder(
        customerId: widget.customerId,
        items: widget.items,
      );

      final orderId = addOrder.data?.id ?? '-';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pesanan berhasil dibuat! ID: $orderId')),
      );

      // refresh daftar setelah berhasil buat order
      setState(() {
        _futureOrders = OrderAPI.getOrders();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuat pesanan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesanan Baru")),
      body: FutureBuilder<ListOrderModel>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.data == null) {
            return const Center(child: Text('Tidak ada pesanan'));
          }

          final layanan = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: layanan.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = layanan.data![index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long, size: 40),
                  title: Text(
                    item.layanan ?? "-",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: ${item.status ?? '-'}"),
                      Text("Total: Rp ${item.total ?? 0}"),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // contoh navigation, sesuaikan route
                    // Navigator.pushNamed(context, '/detail-order', arguments: item.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createOrder,
        child: const Icon(Icons.add),
      ),
    );
  }
}

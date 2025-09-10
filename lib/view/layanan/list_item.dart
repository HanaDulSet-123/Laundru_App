import 'package:flutter/material.dart';
import 'package:laudry_app/api/layananAPI/layanan_api.dart';
import 'package:laudry_app/model/item.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.filterServiceTypeId});
  final int filterServiceTypeId;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<ModelItemData> selectedItems = [];
  Map<ModelItemData, int> itemQuantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Item"),
        backgroundColor: Color(0xFFFAF9EE),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ModelItemData>>(
              future: LayananApi.getItem(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final itemsl = snapshot.data as List<ModelItemData>;
                  final items = itemsl
                      .where((item) =>
                          item.serviceTypeId ==
                          widget.filterServiceTypeId.toString())
                      .toList();
                  return ListView.builder(
                  
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = selectedItems.contains(item);
                      final quantity = itemQuantities[item] ?? 1;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.category?.image ?? "",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.local_laundry_service,
                                    size: 40);
                              },
                            ),
                          ),
                          title: Text(
                            item.name ?? "",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.category?.name} • Rp${item.price}",
                              ),
                              Text(
                                "${item.serviceType?.name}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Checkbox untuk memilih item
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedItems.add(item);
                                      itemQuantities[item] = 1;
                                    } else {
                                      selectedItems.remove(item);
                                      itemQuantities.remove(item);
                                    }
                                  });
                                },
                              ),

                              // Tombol + dan - (hanya muncul jika item dipilih)
                              if (isSelected) ...[
                                IconButton(
                                  icon: Icon(Icons.remove, size: 20),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        itemQuantities[item] = quantity - 1;
                                      } else {
                                        // Jika quantity 1 dan dikurangi, hapus item
                                        selectedItems.remove(item);
                                        itemQuantities.remove(item);
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                                Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$quantity",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, size: 20),
                                  onPressed: () {
                                    setState(() {
                                      itemQuantities[item] = quantity + 1;
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Gagal Memuat data"));
                }
              },
            ),
          ),

          // Container Checkout
          if (selectedItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ringkasan Pesanan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Daftar item yang dipilih
                  for (var item in selectedItems)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${item.serviceType?.name} • Rp${item.price}/item",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Kontrol kuantitas di container checkout
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.remove, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      final quantity =
                                          itemQuantities[item] ?? 1;
                                      if (quantity > 1) {
                                        itemQuantities[item] = quantity - 1;
                                      } else {
                                        selectedItems.remove(item);
                                        itemQuantities.remove(item);
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.all(4),
                                  constraints: BoxConstraints(),
                                ),
                              ),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  "${itemQuantities[item]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      final quantity =
                                          itemQuantities[item] ?? 1;
                                      itemQuantities[item] = quantity + 1;
                                    });
                                  },
                                  padding: EdgeInsets.all(4),
                                  constraints: BoxConstraints(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12),

                          Text(
                            "Rp${(int.tryParse(item.price ?? "0") ?? 0) * itemQuantities[item]!}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Divider(),

                  // Total harga
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Harga",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp${_calculateTotal()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Tombol pesan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _placeOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Pesan Sekarang (${selectedItems.length} item)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Fungsi untuk menghitung total harga
  int _calculateTotal() {
    int total = 0;
    for (var item in selectedItems) {
      final price = int.tryParse(item.price ?? "0") ?? 0;
      final quantity = itemQuantities[item] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Pesanan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Apakah Anda yakin ingin memesan:"),
            SizedBox(height: 8),
            for (var item in selectedItems)
              Text(
                "• ${itemQuantities[item]}x ${item.name}",
                style: TextStyle(fontSize: 12),
              ),
            SizedBox(height: 8),
            Text(
              "Total: Rp${_calculateTotal()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Proses pemesanan di sini
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Pesanan berhasil dibuat!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text("Pesan"),
          ),
        ],
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Item"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ModelItemData>>(
        future: LayananApi.getItem(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final itemsl = snapshot.data as List<ModelItemData>;
            final items = itemsl
                .where((item) =>
                    item.serviceTypeId == widget.filterServiceTypeId.toString())
                .toList();
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
                      ),
                    ),
                    title: Text(
                      item.name ?? "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${item.category?.name} • Rp${item.price}\n${item.serviceType?.name}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Pilih: ${item.name}")),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Text("Gagal Memuat data");
          }
        },
      ),
    );
  }
}

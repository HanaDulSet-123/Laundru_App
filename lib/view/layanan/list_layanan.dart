import 'package:flutter/material.dart';
import 'package:laudry_app/api/layananAPI/layanan_api.dart';
import 'package:laudry_app/extention/extention.dart';
import 'package:laudry_app/model/layanan_api.dart';
import 'package:laudry_app/view/layanan/list_item.dart';

class LayananScreen extends StatefulWidget {
  const LayananScreen({super.key});

  @override
  State<LayananScreen> createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Layanan"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<ModelLayanan>(
        future: LayananApi.getLayanan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final layanan = snapshot.data as ModelLayanan;
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
                    leading: item.category?.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.category!.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.local_laundry_service, size: 40),
                    title: Text(item.name ?? "-",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Waktu pengerjaan: ${item.waktuPengerjaan ?? '-'}"),
                        Text("Kategori: ${item.category?.name ?? '-'}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push(ListItem(filterServiceTypeId: item.id!));
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

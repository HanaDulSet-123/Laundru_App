import 'package:flutter/material.dart';
import 'package:laudry_app/api/layananAPI/layanan_api.dart';
import 'package:laudry_app/extention/extention.dart';
import 'package:laudry_app/model/layanan_model.dart';
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
        backgroundColor: Color(0xFFFAF9EE),
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

// // lib/view/layanan/list_layanan.dart
// import 'package:flutter/material.dart';
// import 'package:laudry_app/api/layananAPI/layanan_api.dart';
// import 'package:laudry_app/model/layanan_model.dart';

// class ListLayananPage extends StatefulWidget {
//   const ListLayananPage({super.key});

//   @override
//   State<ListLayananPage> createState() => _ListLayananPageState();
// }

// class _ListLayananPageState extends State<ListLayananPage> {
//   late Future<List<ModelLayananData>> futureLayanan;

//   @override
//   void initState() {
//     super.initState();
//     Future<List<ModelLayanan>>;
//     LayananApi.getLayanan(); // ✅ ambil dari API
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Daftar Layanan")),
//       body: FutureBuilder<List<ModelLayananData>>(
//         future: futureLayanan,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("Tidak ada layanan"));
//           } else {
//             final layananList = snapshot.data!;
//             return ListView.builder(
//               itemCount: layananList.length,
//               itemBuilder: (context, index) {
//                 final layanan = layananList[index]; // ✅ pakai object model
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text("Harga: Rp${layanan.name}"),
//                     subtitle: Text("Harga: Rp${layanan.price}"),
//                     onTap: () {
//                       // contoh: masuk ke detail layanan
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

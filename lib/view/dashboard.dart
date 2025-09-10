import 'package:flutter/material.dart';
import 'package:laudry_app/api/layananAPI/categori_api.dart';
import 'package:laudry_app/extention/extention.dart';
import 'package:laudry_app/model/get_categori.dart';
import 'package:laudry_app/view/layanan/list_layanan.dart';
import 'package:laudry_app/view/profile_screen.dart';

class Dashboard extends StatefulWidget {
  final String id = "dashboard";
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

// Future<void> _loadUsername() async {
//   //  ambil data dari SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   (() {
//     _loadUsername() = prefs.getString('username') ?? "";
//   });
// }

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final List<Service> _services = [
    Service('Cuci Reguler', 'assets/image/t-shirt.jpg', '2-3 hari', 7000),
    Service('Cuci Kilat', 'assets/image/baju.png', '6 jam', 12000),
    Service('Setrika Saja', 'assets/image/iron.png', '1 hari', 5000),
    Service('Bed Cover', 'assets/image/bed-sheets.png', '3 hari', 30000),
    Service('Karpet', 'assets/image/adornment.png', '4-5 hari', 45000),
    Service('Sepatu', 'assets/image/sneakers.png', '2 hari', 25000),
  ];

  final List<Promo> _promos = [
    Promo('Diskon 20% Cuci Reguler', 'Hanya untuk 50 pelanggan pertama',
        'assets/image/disc.png', Color(0xFFFFE9C9)),
    Promo('Gratis Antar-Jemput', 'Minimal order Rp 50.000',
        'assets/image/fast-delivery.png', Color(0xFFD2F5FE)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/image/logo_new.png',
              width: 100,
              height: 50,
              fit: BoxFit.cover,
            ),
          ],
        ),
        backgroundColor: Color(0xFFFAF9EE),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildSearchBar(),
              SizedBox(height: 25),
              _buildPromoSection(),
              SizedBox(height: 25),
              _buildServicesSection(),
              SizedBox(height: 25),
              _buildHowItWorks(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Pelanggan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Mau laundry apa hari ini?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        // CircleAvatar(
        //   radius: 25,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   child: Icon(
        //     Icons.person,
        //     color: Colors.white,
        //     size: 30,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari layanan laundry...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo Spesial',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _promos.length,
            itemBuilder: (context, index) {
              return _buildPromoCard(_promos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(Promo promo) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: promo.bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo.title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  promo.description,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Klaim Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            promo.imagePath,
            width: 70,
            height: 70,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layanan Kami',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        FutureBuilder<GetCategories>(
          future: CategoriApi.getCategoris(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final users = snapshot.data as GetCategories;
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemCount: users.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  final dataUser = users.data?[index];
                  return _buildServiceCard(dataUser!);
                },
              );
            } else {
              return Text("Gagal Memuat data");
            }
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(GetCategoriesData service) {
    return GestureDetector(
      onTap: () {
        // _showServiceDetail(service);
        context.push(LayananScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.network(
                  service.imageUrl ??
                      "https://koinworks.com/wp-content/uploads/2022/06/faktor-penting-perluas-bisnis-laundry.jpg",
                  width: 30,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              service.name ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            // SizedBox(height: 5),
            // Text(
            //   'Rp ${service.price}/kg',
            //   style: TextStyle(
            //     fontSize: 11,
            //     color: Colors.grey[600],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cara Kerja',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStep('Pesan', Icons.shopping_cart, 0),
            _buildStep('Jemput', Icons.time_to_leave, 1),
            _buildStep('Antar', Icons.delivery_dining, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(String title, IconData icon, int index) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 3),
        Text(
          'Step ${index + 1}',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFAF9EE),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        // if (index == 1) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => OrderListScreen()),
        //   );
        // }
        // if (index == 2) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => RiwayatPesanan()));
        // }
        if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Pesanan',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.history),
        //   label: 'Riwayat',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }

  void _showServiceDetail(Service service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                service.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.access_time, size: 18, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    'Selesai dalam ${service.duration}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Deskripsi Layanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Layanan ${service.name.toLowerCase()} kami memberikan hasil terbaik dengan deterjen berkualitas tinggi dan proses yang higienis.',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Harga',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp ${service.price} / kg',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showOrderDialog(service);
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderDialog(Service service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pesan ${service.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Berat laundry (kg):'),
              SizedBox(height: 10),
              // TextFormField(
              //   controller: beratController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: 'Masukkan berat',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
                child: Text("data"),
                onPressed: () {
                  Navigator.pop(context);

                  // final DetailOrderAPI = {
                  //   "serviceName": service.name,
                  //   "berat": beratController.text,
                  // };
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text('Pesanan ${service.name} berhasil dibuat!'),
                  //     backgroundColor: Colors.green,
                  //   ),
                  // );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OrderListScreen(),
                  //   ),
                  // );
                }),
          ],
        );
      },
    );
  }
}

class Service {
  final String name;
  final String imagePath;
  final String duration;
  final int price;

  Service(this.name, this.imagePath, this.duration, this.price);
}

class Promo {
  final String title;
  final String description;
  final String imagePath;
  final Color bgColor;

  Promo(this.title, this.description, this.imagePath, this.bgColor);
}

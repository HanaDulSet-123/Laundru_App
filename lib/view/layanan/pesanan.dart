import 'package:flutter/material.dart';
import 'package:laudry_app/view/layanan/single_order.dart';

void main() {
  runApp(PesananList());
}

class PesananList extends StatelessWidget {
  const PesananList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaundryExpress - Pesanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFF8FAB4),
        // accentColor: Color(0xFFFFA726),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
      ),
      home: OrderSingle(),
    );
  }
}

// class OrderListScreen extends StatefulWidget {
//   const OrderListScreen({super.key});

//   @override
//   _OrderListScreenState createState() => _OrderListScreenState();
// }

// class _OrderListScreenState extends State<OrderListScreen> {
//   final List<Order> _orders = [
//     Order(
//       id: 'ORD001',
//       date: DateTime(2023, 10, 15),
//       items: '',
//       status: 'Selesai',
//       total: 31000,
//       statusColor: Colors.green,
//     ),
//   ];

//   String _filterStatus = 'Semua';

//   @override
//   Widget build(BuildContext context) {
//     List<Order> filteredOrders = _filterStatus == 'Semua'
//         ? _orders
//         : _orders.where((order) => order.status == _filterStatus).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Riwayat Pesanan'),
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: _showFilterDialog,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildStatsCard(),
//           Expanded(
//             child: filteredOrders.isEmpty
//                 ? Center(
//                     child: Text(
//                       'Tidak ada pesanan dengan status $_filterStatus',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: filteredOrders.length,
//                     itemBuilder: (context, index) {
//                       return _buildOrderCard(filteredOrders[index]);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatsCard() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildStatItem('Semua', _orders.length, Colors.blue),
//           _buildStatItem(
//               'Selesai',
//               _orders.where((order) => order.status == 'Selesai').length,
//               Colors.green),
//           _buildStatItem(
//               'Diproses',
//               _orders.where((order) => order.status == 'Diproses').length,
//               Colors.orange),
//           _buildStatItem(
//               'Menunggu',
//               _orders.where((order) => order.status == 'Menunggu').length,
//               Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(String title, int count, Color color) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             shape: BoxShape.circle,
//           ),
//           child: Text(
//             count.toString(),
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderCard(Order order) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 3,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   order.id,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: order.statusColor.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     order.status,
//                     style: TextStyle(
//                       color: order.statusColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(
//               _formatDate(order.date),
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               order.items,
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: 10),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total:',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 Text(
//                   'Rp ${order.total.toStringAsFixed(0)}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFBB6653),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     _showOrderDetail(order);
//                   },
//                   child: Text('Detail'),
//                 ),
//                 if (order.status == 'Menunggu')
//                   TextButton(
//                     onPressed: () {
//                       _confirmOrderCancellation(order);
//                     },
//                     child: Text(
//                       'Batalkan',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Filter Status'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildFilterOption('Semua'),
//               _buildFilterOption('Menunggu'),
//               _buildFilterOption('Dijemput'),
//               _buildFilterOption('Diproses'),
//               _buildFilterOption('Diantar'),
//               _buildFilterOption('Selesai'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildFilterOption(String status) {
//     return ListTile(
//       title: Text(status),
//       trailing: _filterStatus == status
//           ? Icon(Icons.check, color: Theme.of(context).primaryColor)
//           : null,
//       onTap: () {
//         setState(() {
//           _filterStatus = status;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

//   void _showOrderDetail(Order order) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Detail Pesanan'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('ID: ${order.id}',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 Text('Tanggal: ${_formatDate(order.date)}'),
//                 SizedBox(height: 10),
//                 Text('Status: ${order.status}'),
//                 SizedBox(height: 10),
//                 Text('Items: ${order.items}'),
//                 SizedBox(height: 10),
//                 Text('Total: Rp ${order.total.toStringAsFixed(0)}'),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Tutup'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// void _confirmOrderCancellation(Order order) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Batalkan Pesanan?'),
//         content:
//             Text('Apakah Anda yakin ingin membatalkan pesanan ${order.id}?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Tidak'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _orders.removeWhere((o) => o.id == order.id);
//               });
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Pesanan ${order.id} telah dibatalkan'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             child: Text('Ya', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       );
//     },
//   );
// }

// String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

class Order {
  final String id;
  final DateTime date;
  final String items;
  final String status;
  final int total;
  final Color statusColor;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.status,
    required this.total,
    required this.statusColor,
  });
}

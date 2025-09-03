import 'package:flutter/material.dart';

class buttomnavigation extends StatefulWidget {
  const buttomnavigation({super.key});

  @override
  State<buttomnavigation> createState() => _buttomnavigationState();
}

class _buttomnavigationState extends State<buttomnavigation> {
  static const id = "/bottomNav";
  int _selectedIndex = 0;

  final List<Widget> _pages = [const AboutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF67C090),
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff44444E),
        unselectedItemColor: const Color(0xFF715A5A),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Tentang'),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 188, 235),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Aplikasi ini siap menghibur kegabutan Anda',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text('#Hanna_Slebew', style: TextStyle(fontSize: 16)),
          Text(
            'Versi: 0.0.1',
            style: TextStyle(fontSize: 16, color: Color(0xff21BDCA)),
          ),
        ],
      ),
    );
  }
}

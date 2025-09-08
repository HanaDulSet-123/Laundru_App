import 'package:flutter/material.dart';
import 'package:laudry_app/view/profile_screen.dart';

class ButtomNav16 extends StatefulWidget {
  const ButtomNav16({super.key});
  static const id = "/buttomNav";

  @override
  State<ButtomNav16> createState() => _ButtomNav16State();
}

class _ButtomNav16State extends State<ButtomNav16> {
  // bool appBar = true;
  bool isCheck = false;
  bool isCheckSwitch = false;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Dashbord"), backgroundColor: Colors.blue),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3338A0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // activeIcon: Icon(Icons.abc_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 51, 140, 255),
        onTap: (value) {
          // print(value);
          // print("Nilai SelecetedIndex Before : $_selectedIndex");

          // print("Nilai BotNav : $value");
          setState(() {
            _selectedIndex = value;
          });
          // print("Nilai SelecetedIndex After: $_selectedIndex");
        },
        // onTap: _onItemTapped,
      ),
    );
  }
}

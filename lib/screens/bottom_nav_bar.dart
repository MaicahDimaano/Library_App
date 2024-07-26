import 'package:flutter/material.dart';
import 'package:library_app/screens/home/home_page.dart';
import 'package:library_app/screens/save/save_page.dart';
import 'package:library_app/screens/user_account/user_account.dart'; // Ensure this is the correct import
import 'package:library_app/themes.dart'; // Ensure this defines greenColor and greyColor

class BottomNavBar extends StatefulWidget {
  static const nameRoute = '/BottomNavBar';

  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
     SavePage(), 
     UserProfile(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: greenColor,
        unselectedItemColor: greyColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}

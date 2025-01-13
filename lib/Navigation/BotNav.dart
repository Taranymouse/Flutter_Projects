import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex; // รับ index ปัจจุบัน
  final Function(int) onItemTapped; // Callback เมื่อปุ่มถูกกด

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.yellow[700],
      backgroundColor: Colors.purple[900],
      onTap: onItemTapped,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:demoproject/Navigation/BotNav.dart';
import 'package:demoproject/Navigation/Nav_helper.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.purple[900],
      ),
      body: const Center(
        child: Text(
          'This is the Notification Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: 0, // ระบุว่าอยู่ที่หน้า Profile
        onItemTapped: (index) {
          navigateToPage(context, index, 0); // เรียกฟังก์ชันนำทางและส่ง index ปัจจุบัน
        },
      ),
    );
  }
}

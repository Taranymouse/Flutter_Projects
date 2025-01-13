import 'package:flutter/material.dart';
import 'package:demoproject/Navigation/BotNav.dart';
import 'package:demoproject/Navigation/Nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:demoproject/Profile.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Colors.purple[900],
      ),
      body: const Center(
        child: Text('This is the Home Page'),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: 1, // ระบุว่าอยู่ที่หน้า Home
        onItemTapped: (index) {
          navigateToPage(context, index, 1);
        },
      ),
    );
  }
}

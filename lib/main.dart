import 'package:demoproject/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:demoproject/Screen/Profile.dart';
// import 'package:demoproject/Login/LoginExample.dart';
// import 'package:demoproject/testAPI.dart';
import 'package:demoproject/Screen/home.dart';

void main() {
  runApp(DemoApp());
}

//Custom widget
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Myhomepage(),
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/home': (context) => Myhomepage(), // ลงทะเบียนเส้นทาง
      // },
    );
  }
}

import 'package:demoproject/Login/Login.dart';
import 'package:demoproject/Login/SetPassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:demoproject/Screen/Profile.dart';
// import 'package:demoproject/Login/LoginExample.dart';
// import 'package:demoproject/testAPI.dart';
import 'package:demoproject/Screen/home.dart';
import 'package:demoproject/Login/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const DemoApp(),
    ),
  );
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => Myhomepage(),
        '/set-password': (context) => SetPasswordPage(),
      },
    );
  }
}

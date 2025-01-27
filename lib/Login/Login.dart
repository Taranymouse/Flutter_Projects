import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demoproject/Login/google_auth.dart'; // นำเข้า AuthService
import 'package:provider/provider.dart';
import 'user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginWithGoogle(BuildContext context) async {
    final AuthService _authService = AuthService();
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        final token = await user.getIdToken(true);
        print("ID Token: $token");

        // ส่ง token ไปยัง API เพื่อเช็คข้อมูลผู้ใช้
        final response = await http.post(
          Uri.parse('http://192.168.1.116:8000/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'token': token}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final userEmail = data['email']; // ใช้ email แทน uid
          print("User Email: $userEmail"); // พิมพ์ email ที่ได้จาก Firebase

          // ส่ง email ไปเช็คใน API users
          final userResponse = await http.get(
            Uri.parse('http://192.168.1.116:8000/users'),
          );

          if (userResponse.statusCode == 200) {
            final List<dynamic> usersData = jsonDecode(userResponse.body);
            final userData = usersData.firstWhere(
              (user) => user['email'] == userEmail,
              orElse: () => null,
            );

            if (userData != null) {
              print("User Data: $userData"); // พิมพ์ข้อมูลผู้ใช้จาก API

              // ตั้งค่าผู้ใช้ใน Provider
              Provider.of<UserProvider>(context, listen: false).setUser(
                userData['display_name'],
                userData['email'],
                userData['role'],
                userData['photo_url'] ?? 'default_avatar_url', // ส่ง photo_url ไปที่ Provider
              );

              // ตรวจสอบว่าผู้ใช้มีรหัสผ่านหรือยัง
              if (userData['password'] == null) {
                print(
                    "User does not have a password. Redirecting to set password.");
                Navigator.pushReplacementNamed(context, '/set-password',
                    arguments: userEmail); // ส่ง email ไปที่หน้า SetPassword
              } else {
                print("User already has a password. Redirecting to home.");
                Navigator.pushReplacementNamed(
                    context, '/home'); // ถ้ามีรหัสผ่านแล้ว ไปที่หน้า Home
              }
            } else {
              print("User not found");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User not found")),
              );
            }
          } else {
            print("Failed to fetch user data: ${userResponse.body}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to fetch user data")),
            );
          }
        } else {
          print("Login failed: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: ${response.body}")),
          );
        }
      } else {
        print("Google Sign-In was cancelled");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In was cancelled")),
        );
      }
    } catch (e) {
      print("Login Error: $e"); // พิมพ์ error หากเกิดข้อผิดพลาด
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  Future<void> loginWithEmailPassword(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบถ้วน")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.116:8000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Provider.of<UserProvider>(context, listen: false).setUser(
          data['display_name'],
          data['email'],
          "user",
          data['photo_url'] ?? 'default_avatar_url'
        );

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to connect to server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "IT / CS Projects",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[900],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true, // ซ่อนรหัสผ่าน
            ),
            SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await loginWithEmailPassword(context);
                    },
                    child: Text("Login", style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await loginWithGoogle(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Google", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

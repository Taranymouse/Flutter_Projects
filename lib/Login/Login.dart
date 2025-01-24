import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demoproject/Login/google_auth.dart';  // นำเข้า AuthService

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://192.168.1.116:8000/users/'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบถ้วน")),
      );
      return;
    }

    try {
      final users = await fetchUsers();
      final user = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Welcome ${user['email']}! Role: ${user['role']}")),
        );
        Navigator.pushNamed(
          context,
          '/home',
          arguments: {
            'email': user['email'],
            'role': user['role'],
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password")),
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => login(context),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // เรียกใช้งานฟังก์ชัน signInWithGoogle จาก AuthService
                        final authService = AuthService();
                        final user = await authService.signInWithGoogle();
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Logged in as: ${user.displayName}")),
                          );
                          Navigator.pushNamed(
                            context,
                            '/home',
                            arguments: {
                              'email': user.email,
                              'role': 'Google User',
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Google Sign-In canceled")),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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

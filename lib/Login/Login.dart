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

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.116:8000/users/'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

Future<void> loginWithGoogle(BuildContext context) async {
  final AuthService _authService = AuthService();
  try {
    // ล็อกอินผ่าน Google
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      final token = await user.getIdToken();  // ใช้ getIdToken() เพื่อดึง token
      print("ID Token: $token");  // พิมพ์ token เพื่อตรวจสอบ
      final verifyResponse = await http.post(
        Uri.parse('http://192.168.1.116:8000/verify-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (verifyResponse.statusCode == 200) {
        final verifyData = jsonDecode(verifyResponse.body);
        final uid = verifyData['uid'];

        // ส่งข้อมูลไปที่ google-login
        final googleLoginResponse = await http.post(
          Uri.parse('http://192.168.1.116:8000/google-login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'uid': uid,
            'email': user.email,
          }),
        );

        if (googleLoginResponse.statusCode == 200) {
          final googleLoginData = jsonDecode(googleLoginResponse.body);
          // ตั้งค่าข้อมูลผู้ใช้ใน UserProvider
          Provider.of<UserProvider>(context, listen: false).setUser(
            user.displayName ?? "Anonymous",
            user.email ?? 'unknown@domain.com',
            "user",
          );

          // ไปยังหน้า Home
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Google login failed")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid token")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In was cancelled")),
      );
    }
  } catch (e) {
    // แสดง error หากล็อกอินล้มเหลว
    print("Login Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: $e")),
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
                  //Login Button
                  ElevatedButton(
                    onPressed: () async {
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
                            SnackBar(content: Text("Welcome ${user['email']}! Role: ${user['role']}")),
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
                    },
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

                  //Google Sign in Button
                  ElevatedButton(
                    onPressed: () async {
                      await loginWithGoogle(context);
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

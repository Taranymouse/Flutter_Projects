import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String role;
  final String email;
  final String idUser;
  final String password;

  User({
    required this.role,
    required this.email,
    required this.idUser,
    required this.password,
  });

  // Factory constructor สำหรับแปลง JSON เป็น Object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      role: json['role'],
      email: json['email'],
      idUser: json['id_user'],
      password: json['password'],
    );
  }
}

class ApiTestScreen extends StatefulWidget {
  @override
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  late Future<List<User>> users;

  // ฟังก์ชันสำหรับดึงข้อมูลจาก API
  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.116:8000/users/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(user.email),
                    subtitle: Text("Role: ${user.role} | ID: ${user.idUser}"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

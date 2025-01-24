import 'package:flutter/material.dart';
import 'package:demoproject/Navigation/BotNav.dart';
import 'package:demoproject/Navigation/Nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:demoproject/Screen/Profile.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับ arguments ที่ส่งมาจากหน้า Login
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // ตั้งค่าชื่อและ role
    final String userName = args?['email'] ?? "Anonymouse";
    final String role = args?['role'] ?? "Hacker Role";
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Column(
        children: [
          // TOP
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome back! : ",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0,
                              vertical: 1.0), // เพิ่ม padding ด้านใน
                          color: Colors.purple[900], // กำหนดสีพื้นหลัง
                          child: Text(
                            role,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      userName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Colors.black,
                    )),
              ],
            ),
          ),

          //announcer
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Announcement",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text("แจ้งเตือน"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Navigator
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildButton(
                    context,
                    icon: Icons.description,
                    label: "Documents",
                    color: Colors.blue,
                    onPressed: () {
                      // ตัวอย่าง: แสดงข้อความ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Documents button pressed!")),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    icon: Icons.cloud_upload,
                    label: "Upload",
                    color: Colors.teal,
                    onPressed: () {
                      // ตัวอย่าง: แสดงข้อความ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Upload button pressed!")),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    icon: Icons.checklist,
                    label: "Checklist",
                    color: Colors.orange,
                    onPressed: () {
                      // ตัวอย่าง: แสดงข้อความ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Checklist button pressed!")),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    icon: Icons.contact_mail,
                    label: "Contact",
                    color: Colors.red,
                    onPressed: () {
                      // ตัวอย่าง: แสดงข้อความ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Contact button pressed!")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: 1, // ระบุว่าอยู่ที่หน้า Home
        onItemTapped: (index) {
          navigateToPage(context, index, 1);
        },
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed, // เพิ่มพารามิเตอร์ onPressed
  }) {
    return GestureDetector(
      onTap: onPressed, // ใช้ onPressed เมื่อกด
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 40,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

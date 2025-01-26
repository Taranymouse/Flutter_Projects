import 'package:flutter/material.dart';
import 'package:demoproject/Navigation/BotNav.dart';
import 'package:demoproject/Navigation/Nav_helper.dart';
import 'package:provider/provider.dart';
import 'package:demoproject/Login/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Profile",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 150,
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
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // แสดงชื่อ
                              Text(user.name,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              // แสดงอีเมล
                              Text(user.email),
                              // แสดง role
                              Text(user.role),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Options
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        onTap: () => _editProfile(context),
                      ),
                      // Logout
                      Divider(thickness: 1, color: Colors.grey[300]),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        onTap: () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: 2, // ระบุว่าอยู่ที่หน้า Profile
        onItemTapped: (index) {
          navigateToPage(
              context, index, 2); // เรียกฟังก์ชันนำทางและส่ง index ปัจจุบัน
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    // ลบข้อมูลผู้ใช้จาก Provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser('', '', '');

    // ไปหน้า Login
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
                _logout(context); // เรียกฟังก์ชัน Logout
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editProfile(BuildContext context) {
    // คุณสามารถเพิ่มการทำงานในฟังก์ชันนี้เพื่อให้ผู้ใช้สามารถแก้ไขโปรไฟล์ได้
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Edit Profile functionality not implemented")),
    );
  }
}

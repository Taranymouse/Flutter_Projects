import 'package:flutter/material.dart';
import 'package:demoproject/Navigation/BotNav.dart';
import 'package:demoproject/Navigation/Nav_helper.dart';
import 'package:demoproject/Login/user_provider.dart';
import 'package:provider/provider.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
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
          // TOP - แสดงข้อมูลผู้ใช้
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // แสดงรูปโปรไฟล์ของผู้ใช้
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: user.photoUrl.isNotEmpty
                      ? NetworkImage(user.photoUrl)
                      : null,
                  child: user.photoUrl.isEmpty
                      ? Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 30,
                        )
                      : null,
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
                              horizontal: 1.0, vertical: 1.0),
                          color: Colors.purple[900],
                          child: Text(
                            user.role,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      user.name,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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

          // Announcer Section
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

          // Navigator Section - ปุ่มต่างๆ
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
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
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

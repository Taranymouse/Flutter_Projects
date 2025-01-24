import 'package:flutter/material.dart';
import 'package:demoproject/Screen/home.dart';
import 'package:demoproject/Screen/Profile.dart';
// import 'package:animations/animations.dart';
import 'package:demoproject/Screen/Notification.dart';

void navigateToPage(BuildContext context, int index, int currentIndex) {
  if (index == currentIndex) {
    return;
  }

  Widget nextPage;

  // กำหนดหน้าเป้าหมาย
  switch (index) {
    case 0:
      nextPage = const SearchPage();
      break;
    case 1:
      nextPage = const Myhomepage();
      break;
    case 2:
      nextPage = const ProfilePage();
      break;
    default:
      return;
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration:
          const Duration(milliseconds: 200), // ปรับความเร็ว (500ms)
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)); // ใช้ CurveTween

        return FadeTransition(
          opacity: animation.drive(fadeTween), // ใช้ fadeTween เพื่อปรับเฟด
          child: child,
        );
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:demoproject/home.dart';
import 'package:demoproject/Profile.dart';
import 'package:animations/animations.dart';
import 'package:demoproject/Search.dart';

void navigateToPage(BuildContext context, int index, int currentIndex) {
  if (index == currentIndex) {
    return;
  }

  Widget nextPage;
  Offset beginOffset;
  Offset endOffset;

  // กำหนดหน้าเป้าหมาย
  switch (index) {
    case 0:
      nextPage = const SearchPage();
      beginOffset = const Offset(-1.0, 0.0); // เลื่อนจากซ้าย
      endOffset = Offset.zero;
      break;
    case 1:
      nextPage = const Myhomepage();
      beginOffset = const Offset(0.0, 0.0); // เลื่อนจากขวา
      endOffset = Offset.zero;
      break;
    case 2:
      nextPage = const ProfilePage();
      beginOffset = const Offset(1.0, 0.0); // เลื่อนจากขวา
      endOffset = Offset.zero;
      break;
    default:
      return;
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: beginOffset, end: endOffset)
            .chain(CurveTween(curve: Curves.easeInOut));
        var slideAnimation = animation.drive(tween);

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}

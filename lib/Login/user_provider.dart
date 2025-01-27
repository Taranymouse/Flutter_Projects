import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = 'Anonymouse';
  String _email = 'No Email';
  String _role = 'No Role';
  String _photoUrl = '';

  String get name => _name;
  String get email => _email;
  String get role => _role;
  String get photoUrl => _photoUrl;

  void setUser(String name, String email, String role, String photoUrl) {
    _name = name;
    _email = email;
    _role = role;
    _photoUrl = photoUrl;
    notifyListeners();
  }
}

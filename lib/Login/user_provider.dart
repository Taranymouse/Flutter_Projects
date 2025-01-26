import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = 'Anonymouse';
  String _email = 'No Email';
  String _role = 'No Role';

  String get name => _name;
  String get email => _email;
  String get role => _role;

  void setUser(String name, String email, String role) {
    _name = name;
    _email = email;
    _role = role;
    notifyListeners();
  }
}

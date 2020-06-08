import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _username;
  String _email;
  String _token;
  // if token != null = logged in

  String get username {
    return _username;
  }
   String get email {
    return _email;
  }
   String get token {
    return _token;
  }

  void set(String username, String email, String token) {
    _username = username;
    _email = email;
    _token = token;
    notifyListeners();
  } 

  void clear() {
    _username = null;
    _email = null;
    _token = null;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import '../Helper/Db_helper.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> register(String username, String password, String mobile) async {
    await DatabaseHelper().registerUser(username, password, mobile);
  }

  Future<bool> login(String username, String password) async {
    final user = await DatabaseHelper().getUser(username, password);
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

import 'dart:developer';

import 'package:artriapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  final AuthService _authService;

  LoginViewModel(this._authService);

  handleUserLoginButton() async {
    try {
      print("Sending login request");
      print("API Response ${await _authService.login(email, password)})");
    } catch (e) {
      log('Error on user login, $e');
    }
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }
}

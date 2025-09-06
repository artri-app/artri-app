import 'dart:developer';

import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/utils/routes.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  final AuthService _authService;

  LoginViewModel(this._authService);

  handleUserLoginButton(BuildContext context) async {
    try {
      var response = await _authService.login(email, password);

      if (response.isSuccess) {
        Navigator.pushReplacementNamed(context, Routes.configuration);
      }
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

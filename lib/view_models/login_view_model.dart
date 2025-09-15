import 'dart:developer';

import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/utils/routes.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  final AuthService _authService;
  final SecurityTokenService _securityTokenService;

  LoginViewModel(this._authService, this._securityTokenService);

  Future<void> handleUserLoginButton(BuildContext context) async {
    try {
      var response = await _authService.login(email, password);

      if (response.refreshToken != "" && response.accessToken != "") {
        await _securityTokenService.saveToken(
          response.accessToken,
          SecurityToken.accessToken,
        );
        await _securityTokenService.saveToken(
          response.refreshToken,
          SecurityToken.refreshToken,
        );

        Navigator.pushReplacementNamed(context, Routes.loggedPage);
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

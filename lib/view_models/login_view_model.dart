import 'dart:developer';

import 'package:artriapp/services/auth_service.dart';

class LoginViewModel {
  String email = '';
  String password = '';
  final AuthService _authService;

  LoginViewModel({required AuthService authService})
      : _authService = authService;

  handleUserLoginButton() async {
    try {
      await _authService.login(email, password);
    } catch (e) {
      log('Error on user login');
    }
  }
}

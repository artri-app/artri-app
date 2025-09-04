import 'dart:convert';

import 'package:artriapp/models/api_responses/generic_api_response.dart';
import 'package:artriapp/models/api_responses/user_registration.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _apiUrl = Environment.apiUrl;

  Future<GenericApiResponse> login(
    String user,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$_apiUrl/login/"),
      body: {"username": user, "password": password},
    );

    return GenericApiResponse.fromJson(jsonDecode(response.body));
  }

  Future<UserRegistration> register(
    UserRegistration newUser,
  ) async {
    final response =
        await http.post(Uri.parse("$_apiUrl/register/"), body: newUser.toMap());

    return UserRegistration.fromMap(jsonDecode(response.body));
  }

  Future<Map<String, String>> resetPassword(
    String email,
  ) async {
    final response = await http
        .post(Uri.parse("$_apiUrl/password_reset/"), body: {"email": email});

    return Map<String, String>.from(jsonDecode(response.body));
  }

  Future<Map<String, String>> confirmResetPassword(
    String token,
    String newPassword,
  ) async {
    final response = await http.post(Uri.parse("$_apiUrl/password_reset/"),
        body: {"password": newPassword, "token": token});

    return Map<String, String>.from(jsonDecode(response.body));
  }

  Future<Map<String, String>> validateTokenResetPassword(
    String token,
  ) async {
    final response = await http
        .post(Uri.parse("$_apiUrl/password_reset/"), body: {"token": token});

    return Map<String, String>.from(jsonDecode(response.body));
  }
}

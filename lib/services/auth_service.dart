import 'dart:async';
import 'dart:convert';
import 'package:artriapp/models/api_responses/index.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const _timeout = Duration(seconds: 15);
  final String baseUrl = Environment.apiUrl;

  Future<AuthTokenResponse> login(
    String user,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token/'),
      body: {
        'username': user,
        'password': password,
      },
    ).timeout(_timeout);

    return AuthTokenResponse.fromJson(jsonDecode(response.body));
  }

  Future<UserRegistration> register(
    UserRegistration newUser,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      body: newUser.toMap(),
    ).timeout(_timeout);

    return UserRegistration.fromMap(jsonDecode(response.body));
  }

  Future<Map<String, String>> resetPassword(
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password_reset/'),
      body: {'email': email},
    ).timeout(_timeout);

    return Map<String, String>.from(jsonDecode(response.body));
  }

  Future<Map<String, String>> confirmResetPassword(
    String token,
    String newPassword,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password_reset/'),
      body: {'password': newPassword, 'token': token},
    ).timeout(_timeout);

    return Map<String, String>.from(jsonDecode(response.body));
  }

  Future<Map<String, String>> validateTokenResetPassword(
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password_reset/'),
      body: {'token': token},
    ).timeout(_timeout);

    return Map<String, String>.from(jsonDecode(response.body));
  }

  Future<AuthTokenResponse> refreshAuthToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token/refresh/'),
      body: {'refresh': refreshToken},
    ).timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('Falha ao renovar token: ${response.statusCode} - ${response.body}');
    }

    return AuthTokenResponse.fromJson(jsonDecode(response.body));
  }
}

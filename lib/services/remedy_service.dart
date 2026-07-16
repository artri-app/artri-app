import 'dart:async';
import 'dart:convert';
import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/services/security_token_service.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:artriapp/utils/enums/security_tokens.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:artriapp/utils/exceptions.dart';
import 'package:http/http.dart' as http;

class RemedyService {
  static const _timeout = Duration(seconds: 15);
  final String baseUrl = Environment.apiUrl;
  final SecurityTokenService _tokenService = SecurityTokenService();
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _tokenService.getToken(SecurityToken.accessToken);
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<void> _tryRefreshToken() async {
    final oldRefresh = await _tokenService.getToken(SecurityToken.refreshToken);
    if (oldRefresh == null || oldRefresh.isEmpty) {
      await _tokenService.deleteAllTokens();
      throw AuthExpiredException();
    }
    try {
      final response = await _authService.refreshAuthToken(oldRefresh);
      await _tokenService.saveToken(response.accessToken, SecurityToken.accessToken);
      await _tokenService.saveToken(response.refreshToken, SecurityToken.refreshToken);
    } catch (e) {
      await _tokenService.deleteAllTokens();
      throw AuthExpiredException();
    }
  }

  Future<List<Remedy>> getRemedies() async {
    var headers = await _authHeaders();
    var response = await http.get(
      Uri.parse('$baseUrl/remedies/'),
      headers: headers,
    ).timeout(_timeout);

    if (response.statusCode == 401) {
      await _tryRefreshToken();
      headers = await _authHeaders();
      response = await http.get(
        Uri.parse('$baseUrl/remedies/'),
        headers: headers,
      ).timeout(_timeout);
    }

    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar medicamentos: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Remedy.fromMap(json)).toList();
  }

  Future<Remedy> createRemedy({
    required String name,
    required String description,
    required int quantity,
    required String hour,
    required DaysOfWeek dayOfWeek,
  }) async {
    var headers = await _authHeaders();
    var body = jsonEncode({
      'name': name,
      'description': description.isEmpty ? 'Sem descrição' : description,
      'quantity': quantity,
      'hour': hour,
      'days_of_week': dayOfWeek.apiValue,
    });

    var response = await http.post(
      Uri.parse('$baseUrl/remedies/'),
      headers: headers,
      body: body,
    ).timeout(_timeout);

    if (response.statusCode == 401) {
      await _tryRefreshToken();
      headers = await _authHeaders();
      body = jsonEncode({
        'name': name,
        'description': description.isEmpty ? 'Sem descrição' : description,
        'quantity': quantity,
        'hour': hour,
        'days_of_week': dayOfWeek.apiValue,
      });
      response = await http.post(
        Uri.parse('$baseUrl/remedies/'),
        headers: headers,
        body: body,
      ).timeout(_timeout);
    }

    if (response.statusCode != 201) {
      final errorBody = response.body;
      throw Exception('Falha ao criar medicamento: ${response.statusCode} - $errorBody');
    }

    return Remedy.fromMap(jsonDecode(response.body));
  }

  Future<void> deleteRemedy(int id) async {
    var headers = await _authHeaders();
    var response = await http.delete(
      Uri.parse('$baseUrl/remedies/$id/'),
      headers: headers,
    ).timeout(_timeout);

    if (response.statusCode == 401) {
      await _tryRefreshToken();
      headers = await _authHeaders();
      response = await http.delete(
        Uri.parse('$baseUrl/remedies/$id/'),
        headers: headers,
      ).timeout(_timeout);
    }

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Falha ao deletar medicamento: ${response.statusCode}');
    }
  }
}

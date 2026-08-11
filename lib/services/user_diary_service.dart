import 'dart:convert';

import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:http/http.dart' as http;

class UserDiaryService {
  final String _baseUrl = Environment.apiUrl;
  final SecurityTokenService _tokenService = SecurityTokenService();

  Future<List<int>> getPainLevels() async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.get(
      Uri.parse('$_baseUrl/daily-pain-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['pain_level'] as int).toList();
    }

    throw Exception('Erro ao buscar níveis de dor');
  }

  Future<List<int>> getFatigueLevels() async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.get(
      Uri.parse('$_baseUrl/daily-fatigue-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['fatigue_level'] as int).toList();
    }

    throw Exception('Erro ao buscar níveis de fadiga');
  }

  Future<List<int>> getSleepLevels() async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.get(
      Uri.parse('$_baseUrl/daily-sleep-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['sleep_quality'] as int).toList();
    }

    throw Exception('Erro ao buscar níveis de sono');
  }

  Future<List<int>> getSwellingLevels() async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.get(
      Uri.parse('$_baseUrl/daily-swelling-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['swelling_level'] as int).toList();
    }

    throw Exception('Erro ao buscar níveis de inchaço');
  }

  Future<void> addPainLevel(String bodyOption, int level) async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.post(
      Uri.parse('$_baseUrl/daily-pain-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': DateTime.now().toIso8601String().split('T')[0], // Formato AAAA-MM-DD
        'pain_level': level,
        'pain_location': bodyOption,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao salvar nível de dor: ${response.body}');
    }
  }

  Future<void> addFatigueLevel(int level, String description) async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.post(
      Uri.parse('$_baseUrl/daily-fatigue-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': DateTime.now().toIso8601String().split('T')[0], // Formato AAAA-MM-DD
        'fatigue_level': level,
        'fatigue_description': description,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao salvar nível de fadiga: ${response.body}');
    }
  }

  Future<void> addSleepLevel(int level, int duration) async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.post(
      Uri.parse('$_baseUrl/daily-sleep-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': DateTime.now().toIso8601String().split('T')[0], // Formato AAAA-MM-DD
        'sleep_quality': level,
        'sleep_duration': duration,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao salvar nível de sono: ${response.body}');
    }
  }

  Future<void> addSwellingLevel(String bodyOption, int level) async {
    final String? token = await _tokenService.getToken(SecurityToken.accessToken);

    final response = await http.post(
      Uri.parse('$_baseUrl/daily-swelling-reports/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': DateTime.now().toIso8601String().split('T')[0], // Formato AAAA-MM-DD
        'swelling_level': level,
        'swelling_location': bodyOption,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao salvar nível de inchaço: ${response.body}');
    }
  }
}
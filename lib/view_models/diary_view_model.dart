import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:artriapp/utils/env_variables.dart' as env;

class DiaryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final HttpClient _httpClient = HttpClient();

  DiaryViewModel() {
    // opcional: configurar timeouts no HttpClient
    _httpClient.connectionTimeout = const Duration(seconds: 15);
  }

  /// Método genérico privado para evitar repetição de código
  Future<bool> _enviarMetrica(String endpoint, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final uri = Uri.parse('${env.Environment.apiUrl}$endpoint');
      final request = await _httpClient.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.write(jsonEncode(data));
      final response = await request.close();
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Erro ao comunicar com a API em $endpoint: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // MÉTODOS PÚBLICOS PARA AS PÁGINAS VISUAIS
  // ==========================================================

  Future<bool> enviarRelatorioSono({required int nivel}) async {
    // Substitua 'daily-sleep-report/' pelo endpoint exato do seu urls.py
    return await _enviarMetrica('daily-sleep-report/', {
      'level': nivel, // Confirme se o Serializer espera 'level' ou 'sleep_level'
      'date': DateTime.now().toIso8601String().split('T')[0], // Envia "YYYY-MM-DD"
    });
  }

  Future<bool> enviarRelatorioFadiga({required int nivel}) async {
    return await _enviarMetrica('daily-fatigue-report/', {
      'level': nivel,
      'date': DateTime.now().toIso8601String().split('T')[0],
    });
  }

  Future<bool> enviarRelatorioDor({required int nivel}) async {
    return await _enviarMetrica('daily-pain-report/', {
      'painLevel': nivel, // Exemplo de nome diferente baseado na sua classe DailyPainReport
      'date': DateTime.now().toIso8601String().split('T')[0],
    });
  }

  Future<bool> enviarRelatorioInchaco({required int nivel}) async {
    return await _enviarMetrica('daily-swelling-report/', {
      'level': nivel,
      'date': DateTime.now().toIso8601String().split('T')[0],
    });
  }
}
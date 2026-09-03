import 'dart:convert';

import 'package:artriapp/models/api_responses/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiaryViewModel extends ChangeNotifier {
  static const _timeout = Duration(seconds: 15);

  final SecurityTokenService _securityTokenService;
  final AuthService _authService;

  DiaryViewModel(this._securityTokenService, this._authService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ==========================================================
  // MÉTODOS PÚBLICOS PARA AS PÁGINAS VISUAIS
  // ==========================================================

  /// Envia um registro de Fadiga ou Sono, que não são divididos por região.
  Future<bool> enviarRelatorio({
    required DiaryMetric metrica,
    required int nivel,
  }) async {
    return await _enviarRegistros(metrica, [_montarCorpo(metrica, nivel)]);
  }

  /// Envia um registro de Dor ou Inchaço para cada região marcada.
  Future<bool> enviarRelatorioPorRegiao({
    required DiaryMetric metrica,
    required Map<BodyOptions, int> niveisPorRegiao,
  }) async {
    List<Map<String, dynamic>> registros = niveisPorRegiao.entries
        .map(
          (regiao) => _montarCorpo(metrica, regiao.value,
              regiao: regiao.key.toString()),
        )
        .toList();

    return await _enviarRegistros(metrica, registros);
  }

  Future<bool> enviarRelatorioSono({required int nivel}) async {
    return await enviarRelatorio(metrica: DiaryMetric.sleep, nivel: nivel);
  }

  Future<bool> enviarRelatorioFadiga({required int nivel}) async {
    return await enviarRelatorio(metrica: DiaryMetric.fatigue, nivel: nivel);
  }

  // ==========================================================
  // COMUNICAÇÃO COM A API
  // ==========================================================

  Future<bool> _enviarRegistros(
    DiaryMetric metrica,
    List<Map<String, dynamic>> registros,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      Uri url = _montarUrl(_endpointDaMetrica(metrica));
      Map<String, String> cabecalhos = await _montarCabecalhos();

      for (Map<String, dynamic> registro in registros) {
        http.Response response = await _postar(url, cabecalhos, registro);

        // O token de acesso expira em poucos minutos, então renovamos e
        // tentamos de novo antes de avisar o usuário que falhou.
        if (response.statusCode == 401 && await _renovarTokenDeAcesso()) {
          cabecalhos = await _montarCabecalhos();
          response = await _postar(url, cabecalhos, registro);
        }

        if (response.statusCode != 200 && response.statusCode != 201) {
          debugPrint(
            'Erro ao enviar para $url: ${response.statusCode} - ${response.body}',
          );
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('Erro ao comunicar com a API: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _postar(
    Uri url,
    Map<String, String> cabecalhos,
    Map<String, dynamic> registro,
  ) async {
    return await http.post(
      url,
      headers: cabecalhos,
      body: jsonEncode(registro),
    ).timeout(_timeout);
  }

  Future<bool> _renovarTokenDeAcesso() async {
    String? refreshToken =
        await _securityTokenService.getToken(SecurityToken.refreshToken);

    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      AuthTokenResponse tokens =
          await _authService.refreshAuthToken(refreshToken);

      if (tokens.accessToken.isEmpty) return false;

      await _securityTokenService.saveToken(
        tokens.accessToken,
        SecurityToken.accessToken,
      );

      if (tokens.refreshToken.isNotEmpty) {
        await _securityTokenService.saveToken(
          tokens.refreshToken,
          SecurityToken.refreshToken,
        );
      }

      return true;
    } catch (e) {
      debugPrint('Erro ao renovar o token de acesso: $e');
      return false;
    }
  }

  Future<Map<String, String>> _montarCabecalhos() async {
    String? token =
        await _securityTokenService.getToken(SecurityToken.accessToken);

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Uri _montarUrl(String endpoint) {
    String baseUrl = Environment.apiUrl;

    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    return Uri.parse('$baseUrl/$endpoint');
  }

  Map<String, dynamic> _montarCorpo(
    DiaryMetric metrica,
    int nivel, {
    String? regiao,
  }) {
    Map<String, dynamic> corpo = {
      'date': _dataDeHoje(),
      _campoDeNivel(metrica): nivel,
    };

    String? campoDeRegiao = _campoDeRegiao(metrica);

    if (campoDeRegiao != null) {
      corpo[campoDeRegiao] = regiao ?? '';
    }

    return corpo;
  }

  String _dataDeHoje() {
    return DateTime.now().toIso8601String().split('T').first;
  }

  String _endpointDaMetrica(DiaryMetric metrica) {
    switch (metrica) {
      case DiaryMetric.fatigue:
        return 'daily-fatigue-reports/';
      case DiaryMetric.sleep:
        return 'daily-sleep-reports/';
      case DiaryMetric.pain:
        return 'daily-pain-reports/';
      case DiaryMetric.swelling:
        return 'daily-swelling-reports/';
    }
  }

  String _campoDeNivel(DiaryMetric metrica) {
    switch (metrica) {
      case DiaryMetric.fatigue:
        return 'fatigue_level';
      case DiaryMetric.sleep:
        return 'sleep_level';
      case DiaryMetric.pain:
        return 'pain_level';
      case DiaryMetric.swelling:
        return 'swelling_level';
    }
  }

  String? _campoDeRegiao(DiaryMetric metrica) {
    switch (metrica) {
      case DiaryMetric.pain:
        return 'pain_location';
      case DiaryMetric.swelling:
        return 'swelling_location';
      default:
        return null;
    }
  }
}

import 'dart:convert';
import 'package:artriapp/models/api_responses/index.dart';
import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/services/security_token_service.dart';
import 'package:artriapp/utils/enums/security_tokens.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;

class RemedyService {
  final String baseUrl = Environment.apiUrl;
  final SecurityTokenService _securityTokenService;
  final AuthService _authService;

  RemedyService(this._securityTokenService, this._authService);

  Future<Map<String, String>> _authHeaders() async {
    final token =
        await _securityTokenService.getToken(SecurityToken.accessToken);

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<void> _refreshAccessToken() async {
    final refreshToken =
        await _securityTokenService.getToken(SecurityToken.refreshToken);

    if (refreshToken == null) {
      throw Exception('Sessão expirada. Faça login novamente.');
    }

    final tokens = await _authService.refreshAuthToken(refreshToken);
    await _securityTokenService.saveToken(
      tokens.accessToken,
      SecurityToken.accessToken,
    );
  }

  // O token de acesso (JWT) expira rápido (5min por padrão). Se a requisição
  // vier 401, renova o token e tenta de novo uma única vez.
  Future<http.Response> _authorizedRequest(
    Future<http.Response> Function(Map<String, String> headers) request,
  ) async {
    var response = await request(await _authHeaders());

    if (response.statusCode == 401) {
      await _refreshAccessToken();
      response = await request(await _authHeaders());
    }

    return response;
  }

  Future<List<Remedy>> getRemedies() async {
    final response = await _authorizedRequest(
      (headers) => http.get(Uri.parse('$baseUrl/remedies/'), headers: headers),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Remedy.fromMap(e)).toList();
    } else {
      throw Exception('Erro ao buscar medicamentos');
    }
  }

  Future<Remedy> addRemedy(Remedy remedy) async {
    final response = await _authorizedRequest(
      (headers) => http.post(
        Uri.parse('$baseUrl/remedies/'),
        headers: headers,
        body: jsonEncode(remedy.toMap()),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Remedy.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar medicamento');
    }
  }

  Future<Remedy> updateRemedy(Remedy remedy) async {
    final response = await _authorizedRequest(
      (headers) => http.put(
        Uri.parse('$baseUrl/remedies/${remedy.id}/'),
        headers: headers,
        body: jsonEncode(remedy.toMap()),
      ),
    );

    if (response.statusCode == 200) {
      return Remedy.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar medicamento');
    }
  }

  Future<void> deleteRemedy(int id) async {
    final response = await _authorizedRequest(
      (headers) => http.delete(
        Uri.parse('$baseUrl/remedies/$id/'),
        headers: headers,
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao remover medicamento');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<List<RemedyIntake>> getIntakes(DateTime date) async {
    final response = await _authorizedRequest(
      (headers) => http.get(
        Uri.parse('$baseUrl/remedy-intakes/?date=${_formatDate(date)}'),
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => RemedyIntake.fromMap(e)).toList();
    } else {
      throw Exception('Erro ao buscar registros de uso');
    }
  }

  Future<RemedyIntake> createIntake(int remedyId, DateTime date) async {
    final response = await _authorizedRequest(
      (headers) => http.post(
        Uri.parse('$baseUrl/remedy-intakes/'),
        headers: headers,
        body: jsonEncode({'remedy': remedyId, 'date': _formatDate(date)}),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RemedyIntake.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao marcar remédio como tomado');
    }
  }

  Future<void> deleteIntake(int id) async {
    final response = await _authorizedRequest(
      (headers) => http.delete(
        Uri.parse('$baseUrl/remedy-intakes/$id/'),
        headers: headers,
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao desmarcar remédio como tomado');
    }
  }
}

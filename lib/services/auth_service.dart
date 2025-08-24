import 'dart:convert';

import 'package:artriapp/models/api_responses/generic_api_response.dart';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _apiUrl = Environment.apiUrl;

  Future<GenericApiResponse> login(String user, String password) async {
    final response = await http.post(Uri.parse("$_apiUrl/login/"),
        body: {"username": user, "password": password});

    return GenericApiResponse.fromJson(jsonDecode(response.body));
  }
}

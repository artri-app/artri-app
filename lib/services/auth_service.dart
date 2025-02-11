import 'dart:convert';

import 'package:artriapp/models/generic_api_response.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _apiUrl = 'http://18.222.85.109:8000/api';

  Future<GenericApiResponse> login(String user, String password) async {
    final response = await http.post(Uri.parse("$_apiUrl/login"),
        body: {"username": user, "password": password});

    return GenericApiResponse.fromJson(jsonDecode(response.body));
  }
}

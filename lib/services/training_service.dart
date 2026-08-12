import 'dart:async';
import 'dart:convert';
import 'package:artriapp/utils/env_variables.dart';
import 'package:http/http.dart' as http;
import 'package:artriapp/models/api_responses/index.dart';

class TrainingService {
  static const _timeout = Duration(seconds: 15);
  final String baseUrl = Environment.apiUrl;

  Future<List<Training>> getTrainings() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trainings/'),
    ).timeout(_timeout);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Training.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar trainings');
    }
  }

  Future<List<Exercise>> getExercises() async {
    final response = await http.get(
      Uri.parse('$baseUrl/exercises/'),
    ).timeout(_timeout);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Exercise.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar exercises');
    }
  }
}

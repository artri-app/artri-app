import 'dart:async';
import 'dart:convert';

import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:http/http.dart' as http;

class PhysicalExercisesService {
  static const _timeout = Duration(seconds: 15);
  final String _baseUrl = Environment.apiUrl;

  Future<List<Training>> getTrainings() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/trainings'))
        .timeout(_timeout);

    return List<Training>.from(
      jsonDecode(response.body).map((training) => Training.fromJson(training)),
    );
  }

  Future<List<Exercise>> getExercises() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/exercises'))
        .timeout(_timeout);

    return List<Exercise>.from(
      jsonDecode(response.body).map((exercise) => Exercise.fromJson(exercise)),
    );
  }

  Future<List<Exercise>> getExercisesFromTraining(
    TrainingType type,
    ExerciseDifficulty difficulty,
  ) async {
    final training = await getTrainings().then(
      (trainings) => trainings.firstWhere(
        (training) =>
            training.name.startsWith(type.toString()) &&
            training.difficulty == difficulty,
      ),
    );

    return await getExercises().then(
      (exercises) =>
          exercises.where((e) => training.exercises.contains(e.id)).toList(),
    );
  }
}

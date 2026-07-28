import 'dart:convert';

import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/custom_exercise_category_helper.dart';
import 'package:artriapp/utils/index.dart';
import 'package:http/http.dart' as http;

class PhysicalExercisesService {
  final String _baseUrl = Environment.apiUrl;

  Future<List<Training>> getTrainings() async {
    final response = await http.get(Uri.parse('$_baseUrl/trainings'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar trainings');
    }

    return List<Training>.from(
      jsonDecode(response.body).map((training) => Training.fromJson(training)),
    );
  }

  Future<List<Exercise>> getExercises() async {
    final response = await http.get(Uri.parse('$_baseUrl/exercises'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar exercises');
    }

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
        orElse: () => throw Exception(
          'Nenhum training encontrado para $type ($difficulty)',
        ),
      ),
    );

    return await getExercises().then(
      (exercises) =>
          exercises.where((e) => training.exercises.contains(e.id)).toList(),
    );
  }

  Future<List<Exercise>> getExercisesForCustomCategory(
    TrainingType category,
    ExerciseDifficulty difficulty,
  ) async {
    final trainingName =
        CustomExerciseCategoryHelper.getTrainingName(category, difficulty);

    final training = await getTrainings().then(
      (trainings) => trainings.firstWhere(
        (training) => training.name == trainingName,
        orElse: () => throw Exception(
          'Nenhum training encontrado com o nome "$trainingName"',
        ),
      ),
    );

    return await getExercises().then(
      (exercises) =>
          exercises.where((e) => training.exercises.contains(e.id)).toList(),
    );
  }
}

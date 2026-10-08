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

  Future<Exercise> getExerciseById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/exercise/$id'));
    return Exercise.fromJson(jsonDecode(response.body));
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

    return getCustomExercisesFromIdsList(training.exercises);
  }

  Future<List<Exercise>> getCustomExercisesFromTraining(
    TrainingType type,
    ExerciseDifficulty difficulty,
    int index,
  ) async {
    final List<Exercise> exercises = [];

    final allCustomTrainings = await getTrainings().then(
      (trainings) => trainings.where(
        (training) =>
            training.name.startsWith(type.toString()) &&
            training.difficulty == difficulty,
      ),
    );

    final nthCustomTraining = allCustomTrainings.toList().elementAt(index);

    for (var exerciseId in nthCustomTraining.exercises) {
      final exercise = await getExerciseById(exerciseId);
      exercises.add(exercise);
    }

    return exercises;
  }

  /// Returns the exercises in the same order as [ids], not catalog order.
  Future<List<Exercise>> getCustomExercisesFromIdsList(
    List<int> ids,
  ) async {
    final exercisesById = {
      for (final exercise in await getExercises()) exercise.id: exercise,
    };

    return [
      for (final id in ids)
        if (exercisesById[id] != null) exercisesById[id]!,
    ];
  }
}

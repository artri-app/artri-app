import 'dart:convert';
import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:http/http.dart' as http;

class PhysicalExercisesService {
  final String _baseUrl = Environment.apiUrl;

  Future<List<Training>> getTrainings() async {
    final response = await http.get(Uri.parse('$_baseUrl/trainings'));

    return List<Training>.from(
      jsonDecode(response.body).map((training) => Training.fromJson(training)),
    );
  }

  Future<List<Exercise>> getExercises() async {
    final response = await http.get(Uri.parse('$_baseUrl/exercises'));

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

    return await getExercises().then(
      (exercises) =>
          exercises.where((e) => training.exercises.contains(e.id)).toList(),
    );
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

  Future<List<Exercise>> getCustomExercisesFromIdsList(
    List<int> ids,
  ) {
    return getExercises().then(
      (exercises) => exercises.where((e) => ids.contains(e.id)).toList(),
    );
  }
}

import 'package:artriapp/utils/enums/exercise_difficulty.dart';

class Training {
  final int id;
  final String name;
  final String description;
  final ExerciseDifficulty difficulty;
  final List<int> exercises;

  Training({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'difficulty': difficulty.index,
      'exercises': exercises,
    };
  }

  Training fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      difficulty: ExerciseDifficulty.values[map['difficulty']],
      exercises: List<int>.from(map['exercises']),
    );
  }
}

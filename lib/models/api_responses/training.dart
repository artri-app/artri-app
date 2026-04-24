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

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      difficulty: _parseDifficulty(map['difficulty']),
      exercises: List<int>.from(map['exercises'] ?? []),
    );
  }

  static ExerciseDifficulty _parseDifficulty(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return ExerciseDifficulty.easy;
      case 'medium':
        return ExerciseDifficulty.medium;
      case 'hard':
        return ExerciseDifficulty.hard;
      default:
        return ExerciseDifficulty.easy;
    }
  }
}
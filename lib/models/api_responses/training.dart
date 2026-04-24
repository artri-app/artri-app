import 'package:artriapp/utils/index.dart';

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
      'difficulty': difficulty,
      'exercises': exercises,
    };
  }

  factory Training.fromJson(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      difficulty: ExerciseDifficulty.fromString(map['difficulty']),
      exercises: List<int>.from(map['exercises']),
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

import 'package:artriapp/utils/enums/exercise_difficulty.dart';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String link;
  final ExerciseDifficulty difficulty;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.difficulty,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      link: map['tutorial_link'] ?? '',
      difficulty: _parseDifficulty(map['difficulty']),
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
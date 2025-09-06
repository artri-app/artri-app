import 'package:artriapp/utils/enums/exercise_difficulty.dart';

class Exercise {
  final String id;
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tutorial_link': link,
      'difficulty': difficulty.index,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      link: map['tutorial_link'],
      difficulty: ExerciseDifficulty.values[map['difficulty']],
    );
  }
}

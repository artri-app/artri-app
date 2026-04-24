enum ExerciseDifficulty {
  easy,
  medium,
  hard;

  @override
  toString() {
    switch (this) {
      case ExerciseDifficulty.easy:
        return 'easy';
      case ExerciseDifficulty.medium:
        return 'medium';
      case ExerciseDifficulty.hard:
        return 'hard';
    }
  }

  static ExerciseDifficulty fromString(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return ExerciseDifficulty.easy;
      case 'medium':
        return ExerciseDifficulty.medium;
      case 'hard':
        return ExerciseDifficulty.hard;
      default:
        throw ArgumentError('Invalid difficulty: $difficulty');
    }
  }
}

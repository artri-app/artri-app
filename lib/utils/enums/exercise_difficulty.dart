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
}

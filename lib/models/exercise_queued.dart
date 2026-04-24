import 'package:artriapp/models/index.dart';

class ExerciseQueued extends Exercise {
  bool isCompleted = false;
  bool isFirst;
  bool isLast;

  ExerciseQueued({
    required Exercise exercise,
    this.isFirst = false,
    this.isLast = false,
  }) : super(
          id: exercise.id,
          name: exercise.name,
          description: exercise.description,
          link: exercise.link,
          difficulty: exercise.difficulty,
        );

  void markAsCompleted() {
    isCompleted = true;
  }

  void markAsIncomplete() {
    isCompleted = false;
  }
}

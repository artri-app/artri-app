import 'dart:developer';

import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalExercisesViewModel extends ChangeNotifier {
  TrainingType? _currentTrainingType;
  ExerciseDifficulty? _currentDifficulty;
  List<ExerciseQueued> _queuedExercises = [];
  int? _currentExerciseIndex;
  List<ExerciseQueued> get exercises => _queuedExercises;
  ExerciseQueued? get currentExercise =>
      _queuedExercises[_currentExerciseIndex ?? 0];

  final PhysicalExercisesService _physicalExercisesService;

  PhysicalExercisesViewModel(this._physicalExercisesService);

  void handleTrainingTypeSelection(TrainingType type, BuildContext context) {
    _currentTrainingType = type;

    context.go(_getRouteForTrainingType(type));
  }

  String _getRouteForTrainingType(TrainingType type) {
    switch (type) {
      case TrainingType.hands:
        return PhysicalExerciseRoutes.handExercises;
      case TrainingType.feetBoost:
        return PhysicalExerciseRoutes.feetExercises;
      default:
        return PhysicalExerciseRoutes.customExercises;
    }
  }

  void handleDifficultySelection(
    ExerciseDifficulty difficulty,
    BuildContext context,
  ) async {
    _currentDifficulty = difficulty;

    if (_currentTrainingType == null) {
      log('Error: Training type not selected');
      return;
    }

    var currentPath = RouterHelper.getUriFromContext(context);

    var exercises = await _physicalExercisesService.getExercisesFromTraining(
      _currentTrainingType!,
      _currentDifficulty!,
    );

    _queuedExercises = _queueExercises(exercises);

    context.go('$currentPath/${difficulty.toString()}');
  }

  List<ExerciseQueued> _queueExercises(List<Exercise> exercises) {
    var queue = exercises
        .map(
          (e) => ExerciseQueued(
            exercise: e,
            isFirst: exercises.indexOf(e) == 0,
            isLast: exercises.indexOf(e) == exercises.length - 1,
          ),
        )
        .toList();

    return queue;
  }

  void handleNextExercise() {
    if (_currentExerciseIndex == null) {
      log('Error: No current exercise');
      return;
    }

    if (currentExercise!.isLast) {
      log('Info: Already at the last exercise');
      return;
    }

    _currentExerciseIndex = _currentExerciseIndex! + 1;

    notifyListeners();
  }

  void handlePreviousExercise() {
    if (_currentExerciseIndex == null) {
      log('Error: No current exercise');
      return;
    }

    if (currentExercise!.isFirst) {
      log('Info: Already at the first exercise');
      return;
    }

    _currentExerciseIndex = _currentExerciseIndex! - 1;

    notifyListeners();
  }

  void handleStartExercises(BuildContext context) {
    _currentExerciseIndex = 0;

    context.go('${RouterHelper.getUriFromContext(context)}/exercise');
  }
}

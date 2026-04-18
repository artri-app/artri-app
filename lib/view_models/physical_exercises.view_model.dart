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
  List<Exercise> _exercises = [];
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

    _exercises = await _physicalExercisesService.getExercisesFromTraining(
      _currentTrainingType!,
      _currentDifficulty!,
    );

    context.go('$currentPath/${difficulty.toString()}');
  }
}

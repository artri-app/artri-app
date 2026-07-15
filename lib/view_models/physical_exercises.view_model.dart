import 'dart:developer';

import 'package:artriapp/models/exercise_list_by_type.dart';
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
  ExerciseDifficulty? get currentDifficulty => _currentDifficulty;
  List<ExerciseListByType> _selectionList = [];
  List<Exercise> _currentPageList = [];
  List<ExerciseListByType> get selectionList => _selectionList;
  List<Exercise> get currentPageList => _currentPageList;
  List<ExerciseListByType> _customExerciseList = [];
  List<ExerciseQueued> _queuedExercises = [];
  int? _currentExerciseIndex;
  int _currentCustomTrainingPage = 0;
  int get currentCustomTrainingPage => _currentCustomTrainingPage;
  List<ExerciseQueued> get exercises => _queuedExercises;
  List<ExerciseListByType> get customExerciseList => _customExerciseList;

  ExerciseQueued? get currentExercise => _currentExerciseIndex == null
      ? null
      : _queuedExercises[_currentExerciseIndex ?? 0];

  final PhysicalExercisesService _physicalExercisesService;

  final List<TrainingType> customExerciseRoutineTrainingTypeList = [
    TrainingType.mobility,
    TrainingType.aerobic,
    TrainingType.inferiorBoost,
    TrainingType.superiorBoost,
    TrainingType.coreBoost,
    TrainingType.stretching,
  ];

  PhysicalExercisesViewModel(this._physicalExercisesService);

  void handleTrainingTypeSelection(TrainingType type, BuildContext context) {
    _currentTrainingType = type;

    context.push(_getRouteForTrainingType(type));
  }

  void goToCustomTrainingPage(BuildContext context) {
      context.push(PhysicalExerciseRoutes.selectCustomExercisesDifficulty);
  }

  void returnSelectExercisesPage() {
    _currentCustomTrainingPage--;
  }

  void goToSelectExercises(int index, BuildContext context) {
    if (index < _selectionList.length) {
      _currentCustomTrainingPage = index;
      context.push(PhysicalExerciseRoutes.selectExercises);
    } else {
      context.push(PhysicalExerciseRoutes.confirmationRoute);
    }
  }

  void toggleExerciseInList(Exercise exercise) {
    if (_customExerciseList[_currentCustomTrainingPage].exerciseList.contains(exercise)) {
      _customExerciseList[_currentCustomTrainingPage].exerciseList.remove(exercise);
    } else {
      _customExerciseList[_currentCustomTrainingPage].exerciseList.add(exercise);
    }

    notifyListeners();
  }

  void setCustomExercisesDificulty(ExerciseDifficulty difficulty, BuildContext context) {
    _currentDifficulty = difficulty;
    context.push(PhysicalExerciseRoutes.customExercises);
  }

  String _getRouteForTrainingType(TrainingType type) {
    switch (type) {
      case TrainingType.hands:
        return PhysicalExerciseRoutes.handExercises;
      case TrainingType.feet:
        return PhysicalExerciseRoutes.feetExercises;
      default:
        return PhysicalExerciseRoutes.customExercises;
    }
  }

  void handleDifficultySelection(
    ExerciseDifficulty difficulty,
    BuildContext context,
  ) async {
    _selectionList = [];
    _customExerciseList = [];

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

    context.push('$currentPath/${difficulty.toString()}');
  }

  void resetExerciseList() {
    _currentExerciseIndex = null;
    _queuedExercises = [];
    notifyListeners();
  }

  Future<void> getExerciseList(TrainingType type) async {
    _selectionList = [];
    _customExerciseList = [];
    List<Exercise> _newList = [];
    for (int i = 0; i < customExerciseRoutineTrainingTypeList.length; i++) {
      _newList = await _physicalExercisesService.getExercisesFromTraining(
        customExerciseRoutineTrainingTypeList[i],
        _currentDifficulty ?? ExerciseDifficulty.easy,
        isCustomExercise: true,
      );
      _selectionList.add(ExerciseListByType(exerciseList: _newList, type: customExerciseRoutineTrainingTypeList[i]));
      _customExerciseList.add(ExerciseListByType(exerciseList: [], type: customExerciseRoutineTrainingTypeList[i]));
    }
  }

  void queueCustomExercises(BuildContext context) {
    List<Exercise> allExercises = [];
    for (int i = 0; i < customExerciseRoutineTrainingTypeList.length; i++) {
      for (var element in _customExerciseList[i].exerciseList) {
        allExercises.add(element);
      }
    }
    _queuedExercises = _queueExercises(allExercises);
    handleStartExercises(context);
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

    _currentExerciseIndex = 0;

    return queue;
  }

  void handleNextExercise(BuildContext context) {
    if (_currentExerciseIndex == null) {
      log('Error: No current exercise');
      return;
    }

    if (currentExercise!.isLast) {
      context.go(PhysicalExerciseRoutes.congratulations);
      return;
    }

    _currentExerciseIndex = _currentExerciseIndex! + 1;

    context.push(getExerciseRoute(context));
  }

  void handlePreviousExercise(BuildContext context) {
    if (_currentExerciseIndex == null) {
      log('Error: No current exercise');
      return;
    }

    if (currentExercise!.isFirst) {
      log('Info: Already at the first exercise');
      return;
    }

    _currentExerciseIndex = _currentExerciseIndex! - 1;

    context.pop();
  }

  void handleStartExercises(BuildContext context) {
    _currentExerciseIndex = 0;

    context.push(getExerciseRoute(context));
  }

  void handleCompleteExercise(BuildContext context) {
    if (_currentExerciseIndex == null) {
      log('Error: No current exercise');
      return;
    }

    currentExercise!.markAsCompleted();
    handleNextExercise(context);
  }

  String getExerciseRoute(BuildContext context) {
    var currentPath = RouterHelper.getUriFromContext(context);
    var currentPathSegments = currentPath.pathSegments;
    var hasCurrentExerciseId = int.tryParse(currentPathSegments.last) != null;
    var cleanedPath = currentPath.path;

    if (hasCurrentExerciseId || _customExerciseList.isNotEmpty) {
      cleanedPath =
          '/${currentPathSegments.sublist(0, currentPathSegments.length - 1).join('/')}';
    }

    return '$cleanedPath/${currentExercise!.id}';
  }
}

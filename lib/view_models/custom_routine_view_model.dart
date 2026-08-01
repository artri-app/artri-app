import 'package:artriapp/models/index.dart';
import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:flutter/foundation.dart';

class CustomRoutineViewModel extends ChangeNotifier {
  final PhysicalExercisesService _exerciseService;

  CustomRoutineTemplate? currentTemplate;
  final Map<String, List<Exercise>> selectedExercises = {};
  List<Exercise> catalog = [];
  bool isLoading = false;

  CustomRoutineViewModel(this._exerciseService);

  /// Maps a level key to the segment used in training names on the API.
  static const Map<String, String> _levelNameMap = {
    'iniciante': 'INICIANTE',
    'intermediario': 'INTERMEDIÁRIO',
    'avancado': 'AVANÇADO',
  };

  /// Maps a category key to the segment used in training names on the API.
  static const Map<String, String> _categoryNameMap = {
    'mobilidade': 'MOBILIDADE',
    'aquecimento': 'AQUECIMENTO',
    'pernas': 'PERNAS',
    'bracos': 'BRAÇOS',
    'tronco': 'TRONCO',
    'alongamento': 'ALONGAMENTO',
  };

  List<Exercise> exercisesForCategory(String categoryKey) {
    return _categoryCatalog[categoryKey] ?? [];
  }

  bool isExerciseSelected(String categoryKey, int exerciseId) {
    return selectedExercises[categoryKey]?.any((e) => e.id == exerciseId) ?? false;
  }

  Map<String, List<Exercise>> _categoryCatalog = {};

  Future<void> initRoutine(String level) async {
    isLoading = true;
    notifyListeners();

    currentTemplate = CustomRoutineTemplate.mock(level);
    selectedExercises.clear();
    _categoryCatalog.clear();
    catalog = [];

    for (final cat in currentTemplate!.categories) {
      selectedExercises[cat.key] = [];
      _categoryCatalog[cat.key] = [];
    }

    try {
      final trainings = await _exerciseService.getTrainings();
      catalog = await _exerciseService.getExercises();

      final levelName = _levelNameMap[level] ?? 'INICIANTE';

      for (final cat in currentTemplate!.categories) {
        final catName = _categoryNameMap[cat.key] ?? cat.key.toUpperCase();

        // Find the matching training by checking the training name contains
        // both the level and category segments (e.g. "PERSONALIDADO ... INICIANTE ... MOBILIDADE").
        final matchingTrainings = trainings.where((t) =>
            t.name.toUpperCase().contains('PERSONALIDADO') &&
            t.name.toUpperCase().contains(levelName) &&
            t.name.toUpperCase().contains(catName));

        if (matchingTrainings.isNotEmpty) {
          final training = matchingTrainings.first;
          final categoryExercises =
              catalog.where((e) => training.exercises.contains(e.id)).toList();
          _categoryCatalog[cat.key] = categoryExercises;
        }
      }
    } catch (e) {
      debugPrint('[CustomRoutineViewModel] Failed to fetch catalog: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  bool toggleExercise(Exercise exercise, String category) {
    final list = selectedExercises[category];
    if (list == null) return false;

    final existingIndex = list.indexWhere((e) => e.id == exercise.id);
    if (existingIndex >= 0) {
      list.removeAt(existingIndex);
      notifyListeners();
      return true;
    }

    final cat = currentTemplate!.categories.firstWhere((c) => c.key == category);
    if (list.length >= cat.requiredCount) {
      debugPrint('[CustomRoutineViewModel] Category $category already at limit (${cat.requiredCount})');
      return false;
    }

    list.add(exercise);
    notifyListeners();
    return true;
  }

  bool isCategoryComplete(String category) {
    final cat = currentTemplate?.categories.firstWhere(
      (c) => c.key == category,
      orElse: () => TemplateCategory(key: category, title: '', requiredCount: 0, prepText: '', prompt: ''),
    );
    final selectedCount = selectedExercises[category]?.length ?? 0;
    return selectedCount >= cat!.requiredCount;
  }

  bool canStartRoutine() {
    final template = currentTemplate;
    if (template == null) return false;
    for (final cat in template.categories) {
      if (!isCategoryComplete(cat.key)) return false;
    }
    return true;
  }

  List<Exercise> generateFinalRoutine() {
    final template = currentTemplate;
    if (template == null) return [];

    final flattened = <Exercise>[];
    for (final cat in template.categories) {
      final selected = selectedExercises[cat.key] ?? [];
      flattened.addAll(selected);
    }
    return flattened;
  }
}

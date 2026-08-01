import 'package:artriapp/models/index.dart';
import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:flutter/material.dart';

class CustomRoutineAdvancedViewModel extends ChangeNotifier {
  final List<String> categories = const [
    'mobilidade',
    'aquecimento',
    'pernas',
    'bracos',
    'tronco',
    'alongamento',
  ];

  final Map<String, String> categoryLabels = const {
    'mobilidade': 'Mobilidade',
    'aquecimento': 'Aquecimento',
    'pernas': 'Pernas',
    'bracos': 'Braços',
    'tronco': 'Tronco',
    'alongamento': 'Alongamento',
  };

  static const Map<String, String> _categoryNameMap = {
    'mobilidade': 'MOBILIDADE',
    'aquecimento': 'AQUECIMENTO',
    'pernas': 'PERNAS',
    'bracos': 'BRAÇOS',
    'tronco': 'TRONCO',
    'alongamento': 'ALONGAMENTO',
  };

  final Map<String, List<Exercise>> _categoryExercises = {};
  final Set<int> _selectedExerciseIds = {};
  String _searchQuery = '';
  String? _selectedCategory;
  bool isLoading = false;

  final PhysicalExercisesService _exerciseService;

  CustomRoutineAdvancedViewModel(this._exerciseService) {
    _initMockData();
  }

  Future<void> initCatalog() async {
    isLoading = true;
    notifyListeners();

    try {
      final trainings = await _exerciseService.getTrainings();
      final catalog = await _exerciseService.getExercises();

      if (trainings.isNotEmpty && catalog.isNotEmpty) {
        _categoryExercises.clear();
        for (final cat in categories) {
          final catName = _categoryNameMap[cat] ?? cat.toUpperCase();

          // Find matching trainings that contain both "PERSONALIDADO" and category name
          final matchingTrainings = trainings.where((t) =>
              t.name.toUpperCase().contains('PERSONALIDADO') &&
              t.name.toUpperCase().contains(catName));

          final categoryExercises = <Exercise>[];

          for (final t in matchingTrainings) {
            for (final exerciseId in t.exercises) {
              final exercise = catalog.firstWhere(
                (e) => e.id == exerciseId,
                orElse: () => null as dynamic,
              );
              if (exercise != null &&
                  !categoryExercises.any((e) => e.id == exercise.id)) {
                categoryExercises.add(exercise);
              }
            }
          }

          _categoryExercises[cat] = categoryExercises;
        }
      }
    } catch (e) {
      debugPrint('[CustomRoutineAdvancedViewModel] Failed to fetch catalog: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _initMockData() {
    _categoryExercises['mobilidade'] = [
      Exercise(
        id: 1001,
        name: 'Círculos com a perna',
        description: 'Faça movimentos circulares suaves com a perna.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: 10, sets: 2, duration: null),
      ),
      Exercise(
        id: 1002,
        name: 'Círculos com o tornozelo',
        description: 'Faça movimentos circulares suaves com o tornozelo.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: 15, sets: 2, duration: null),
      ),
      Exercise(
        id: 1003,
        name: 'Pernas para frente e para trás',
        description: 'Balança as pernas suavemente para frente e para trás.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: 10, sets: 2, duration: null),
      ),
      Exercise(
        id: 1004,
        name: 'Círculos com os braços',
        description: 'Faça movimentos circulares suaves com os braços.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: 10, sets: 2, duration: null),
      ),
      Exercise(
        id: 1005,
        name: 'Subir e descer os ombros',
        description: 'Suba os ombros em direção às orelhas e solte devagar.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: 12, sets: 2, duration: null),
      ),
    ];

    _categoryExercises['aquecimento'] = [
      Exercise(
        id: 2001,
        name: 'Polichinelos adaptados',
        description: 'Abra e feche os braços e pernas de forma controlada.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 20, sets: 2, duration: null),
      ),
      Exercise(
        id: 2002,
        name: 'Corrida estacionária',
        description: 'Marche no lugar sem sair do ponto de apoio.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: null, sets: 2, duration: 30),
      ),
      Exercise(
        id: 2003,
        name: 'Elevação de joelhos',
        description: 'Suba os joelhos alternadamente até a altura do quadril.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 10, sets: 2, duration: null),
      ),
    ];

    _categoryExercises['pernas'] = [
      Exercise(
        id: 3001,
        name: 'Agachamento com cadeira',
        description: 'Sente e levante de uma cadeira firme de forma controlada.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 20, reps: 10, sets: 3, duration: null),
      ),
      Exercise(
        id: 3002,
        name: 'Afundo apoiado',
        description: 'Faça o afundo segurando em um apoio firme para equilíbrio.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.medium,
        details: ExerciseDetails(rest: 20, reps: 8, sets: 3, duration: null),
      ),
      Exercise(
        id: 3003,
        name: 'Elevação pélvica',
        description: 'Deitado de costas, eleve o quadril contraindo os glúteos.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 12, sets: 3, duration: null),
      ),
    ];

    _categoryExercises['bracos'] = [
      Exercise(
        id: 4001,
        name: 'Elevação lateral dos braços',
        description: 'Eleve os braços esticados lateralmente até a altura dos ombros.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 12, sets: 3, duration: null),
      ),
      Exercise(
        id: 4002,
        name: 'Dobrar o cotovelo',
        description: 'Dobre e estenda os cotovelos simulando rosca bíceps.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 15, sets: 3, duration: null),
      ),
      Exercise(
        id: 4003,
        name: 'Elevação frontal dos braços',
        description: 'Eleve os braços para frente até a altura dos ombros.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 12, sets: 3, duration: null),
      ),
      Exercise(
        id: 4004,
        name: 'Rotação do braço para fora',
        description: 'Com cotovelos a 90 graus junto ao corpo, afaste as mãos rotacionando para fora.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 12, sets: 3, duration: null),
      ),
      Exercise(
        id: 4005,
        name: 'Rotação do braço para dentro',
        description: 'Rotacione os braços para dentro de forma controlada.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 15, reps: 12, sets: 3, duration: null),
      ),
    ];

    _categoryExercises['tronco'] = [
      Exercise(
        id: 5001,
        name: 'Abdominal supra',
        description: 'Deitado de costas, eleve levemente os ombros do chão.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 20, reps: 15, sets: 3, duration: null),
      ),
      Exercise(
        id: 5002,
        name: 'Prancha frontal inclinada',
        description: 'Apoie os cotovelos em uma superfície alta e mantenha o corpo alinhado.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.medium,
        details: ExerciseDetails(rest: 20, reps: null, sets: 3, duration: 20),
      ),
      Exercise(
        id: 5003,
        name: 'Super-homem',
        description: 'Deitado de bruços, levante levemente o tronco e pernas.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.medium,
        details: ExerciseDetails(rest: 20, reps: 10, sets: 3, duration: null),
      ),
    ];

    _categoryExercises['alongamento'] = [
      Exercise(
        id: 6001,
        name: 'Alongamento de posterior de coxa',
        description: 'Estenda a perna à frente e incline o tronco suavemente.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: null, sets: 2, duration: 20),
      ),
      Exercise(
        id: 6002,
        name: 'Alongamento de quadríceps',
        description: 'Fique em um pé só, puxe o outro pé atrás em direção ao glúteo.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: null, sets: 2, duration: 20),
      ),
      Exercise(
        id: 6003,
        name: 'Alongamento de peitoral',
        description: 'Apoie a mão em uma parede e rotacione o tronco no sentido oposto.',
        tutorialLink: 'https://www.youtube.com/watch?v=IxX_QHay02M',
        difficulty: ExerciseDifficulty.easy,
        details: ExerciseDetails(rest: 10, reps: null, sets: 2, duration: 20),
      ),
    ];
  }

  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  Set<int> get selectedExerciseIds => _selectedExerciseIds;

  int get selectedCount => _selectedExerciseIds.length;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(String? categoryKey) {
    _selectedCategory = categoryKey;
    notifyListeners();
  }

  void toggleExerciseSelection(int exerciseId) {
    if (_selectedExerciseIds.contains(exerciseId)) {
      _selectedExerciseIds.remove(exerciseId);
    } else {
      _selectedExerciseIds.add(exerciseId);
    }
    notifyListeners();
  }

  bool isExerciseSelected(int exerciseId) {
    return _selectedExerciseIds.contains(exerciseId);
  }

  List<Exercise> get filteredExercises {
    final List<Exercise> results = [];
    final categoriesToSearch = _selectedCategory == null
        ? categories
        : [_selectedCategory!];

    for (var cat in categoriesToSearch) {
      final exercises = _categoryExercises[cat] ?? [];
      for (var exercise in exercises) {
        if (_searchQuery.isEmpty ||
            exercise.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
          results.add(exercise);
        }
      }
    }
    return results;
  }

  List<Exercise> generateRoutine() {
    final List<Exercise> selected = [];
    for (var cat in categories) {
      final exercises = _categoryExercises[cat] ?? [];
      for (var exercise in exercises) {
        if (_selectedExerciseIds.contains(exercise.id)) {
          selected.add(exercise);
        }
      }
    }
    return selected;
  }

  void clearSelection() {
    _selectedExerciseIds.clear();
    notifyListeners();
  }
}

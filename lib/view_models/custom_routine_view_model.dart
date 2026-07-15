import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:flutter/foundation.dart';

class CustomRoutineCategory {
  final String key;
  final String title;
  final int requiredCount;
  final String prepText;
  final String prompt;

  const CustomRoutineCategory({
    required this.key,
    required this.title,
    required this.requiredCount,
    required this.prepText,
    required this.prompt,
  });
}

class CustomRoutineViewModel extends ChangeNotifier {
  final List<CustomRoutineCategory> categories = const [
    CustomRoutineCategory(
      key: 'mobilidade',
      title: 'Mobilidade',
      requiredCount: 2,
      prepText: 'de mobilidade',
      prompt: 'Selecione 2 exercícios de mobilidade das opções abaixo:',
    ),
    CustomRoutineCategory(
      key: 'aquecimento',
      title: 'Aquecimento',
      requiredCount: 2,
      prepText: 'de aquecimento',
      prompt: 'Selecione 2 exercícios de aquecimento das opções abaixo:',
    ),
    CustomRoutineCategory(
      key: 'pernas',
      title: 'Pernas',
      requiredCount: 2,
      prepText: 'para as pernas',
      prompt: 'Selecione 2 exercícios para as pernas das opções abaixo:',
    ),
    CustomRoutineCategory(
      key: 'bracos',
      title: 'Braços',
      requiredCount: 2,
      prepText: 'para os braços',
      prompt: 'Selecione 2 exercícios para os braços das opções abaixo:',
    ),
    CustomRoutineCategory(
      key: 'tronco',
      title: 'Tronco',
      requiredCount: 2,
      prepText: 'para o tronco',
      prompt: 'Selecione 2 exercícios para o tronco das opções abaixo:',
    ),
    CustomRoutineCategory(
      key: 'alongamento',
      title: 'Alongamento',
      requiredCount: 2,
      prepText: 'de alongamento',
      prompt: 'Selecione 2 exercícios de alongamento das opções abaixo:',
    ),
  ];

  final Map<String, List<Exercise>> _categoryExercises = {};
  final Map<String, List<int>> _selectedExerciseIds = {};

  CustomRoutineViewModel() {
    _initMockData();
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

    for (var cat in categories) {
      _selectedExerciseIds[cat.key] = [];
    }
  }

  List<Exercise> getExercisesForCategory(String categoryKey) {
    return _categoryExercises[categoryKey] ?? [];
  }

  bool isExerciseSelected(String categoryKey, int exerciseId) {
    return _selectedExerciseIds[categoryKey]?.contains(exerciseId) ?? false;
  }

  void toggleExercise(String categoryKey, int exerciseId) {
    final list = _selectedExerciseIds[categoryKey];
    if (list == null) return;

    if (list.contains(exerciseId)) {
      list.remove(exerciseId);
    } else {
      list.add(exerciseId);
    }
    notifyListeners();
  }

  bool isCategoryComplete(String categoryKey) {
    final cat = categories.firstWhere((c) => c.key == categoryKey);
    final selectedCount = _selectedExerciseIds[categoryKey]?.length ?? 0;
    return selectedCount == cat.requiredCount;
  }

  bool canStartRoutine() {
    for (var cat in categories) {
      if (!isCategoryComplete(cat.key)) {
        return false;
      }
    }
    return true;
  }

  List<Exercise> generateFinalRoutine() {
    final List<Exercise> flattened = [];
    for (var cat in categories) {
      final selectedIds = _selectedExerciseIds[cat.key] ?? [];
      final allExercises = _categoryExercises[cat.key] ?? [];
      final selected = allExercises.where((e) => selectedIds.contains(e.id)).toList();
      flattened.addAll(selected);
    }
    return flattened;
  }
}

import 'package:artriapp/models/index.dart';
import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockPhysicalExercisesService extends PhysicalExercisesService {
  @override
  Future<List<Training>> getTrainings() async {
    return [
      Training(
        id: 1,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - MOBILIDADE',
        description: '',
        exercises: [1001, 1002, 1003, 1004, 1005],
        difficulty: ExerciseDifficulty.easy,
      ),
      Training(
        id: 2,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - AQUECIMENTO',
        description: '',
        exercises: [2001, 2002],
        difficulty: ExerciseDifficulty.easy,
      ),
      Training(
        id: 3,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - PERNAS',
        description: '',
        exercises: [3001, 3002],
        difficulty: ExerciseDifficulty.easy,
      ),
      Training(
        id: 4,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - BRAÇOS',
        description: '',
        exercises: [4001, 4002],
        difficulty: ExerciseDifficulty.easy,
      ),
      Training(
        id: 5,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - TRONCO',
        description: '',
        exercises: [5001, 5002],
        difficulty: ExerciseDifficulty.easy,
      ),
      Training(
        id: 6,
        name: 'EXERCÍCIO PERSONALIDADO - INICIANTE - ALONGAMENTO',
        description: '',
        exercises: [6001, 6002],
        difficulty: ExerciseDifficulty.easy,
      ),
    ];
  }

  @override
  Future<List<Exercise>> getExercises() async {
    return [
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
      // aquecimento
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
      // pernas
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
      // bracos
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
      // tronco
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
      // alongamento
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
    ];
  }
}

Widget _createTestApp({
  required CustomRoutineViewModel customVM,
  required PhysicalExercisesViewModel physicalVM,
  required Widget child,
}) {
  return MaterialApp(
    home: Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomRoutineViewModel>.value(value: customVM),
          ChangeNotifierProvider<PhysicalExercisesViewModel>.value(value: physicalVM),
        ],
        child: child,
      ),
    ),
  );
}

void main() {
  late CustomRoutineViewModel customVM;
  late PhysicalExercisesViewModel physicalVM;

  setUpAll(() async {
    await dotenv.load();
  });

  setUp(() {
    final mockService = MockPhysicalExercisesService();
    customVM = CustomRoutineViewModel(mockService);
    physicalVM = PhysicalExercisesViewModel(mockService);
  });

  group('CustomRoutineOverviewPage Tests', () {
    testWidgets('renders overview page title description and list of categories', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CustomRoutineOverviewPage(level: 'iniciante'),
        ),
      );
      // Let the Future inside initState complete
      await tester.pump();
      await tester.pump();

      // Check description text
      expect(
        find.textContaining('Vamos começar a montar sua rotina'),
        findsOneWidget,
      );

      // Check category texts
      expect(find.text('Escolha 2 exercícios de'), findsNWidgets(3));
      expect(find.text('Escolha 2 exercícios para'), findsNWidgets(3));
      expect(find.text('mobilidade'), findsOneWidget);
      expect(find.text('aquecimento'), findsOneWidget);
      expect(find.text('alongamento'), findsOneWidget);
      expect(find.text('pernas'), findsOneWidget);
      expect(find.text('braços'), findsOneWidget);
      expect(find.text('tronco'), findsOneWidget);

      // Start button is disabled (has null onPressed, grayed out gradient)
      final startButtonFinder = find.widgetWithText(CustomSolidButton, 'COMEÇAR');
      expect(startButtonFinder, findsOneWidget);
      final startButton = tester.widget<CustomSolidButton>(startButtonFinder);
      expect(startButton.onPressed, isNull);
    });

    testWidgets('shows checkmarks when categories are completed and enables start button', (tester) async {
      // Complete all categories manually in the view model
      await customVM.initRoutine('iniciante');
      for (var cat in customVM.currentTemplate!.categories) {
        final exercises = customVM.exercisesForCategory(cat.key);
        customVM.toggleExercise(exercises[0], cat.key);
        customVM.toggleExercise(exercises[1], cat.key);
      }

      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CustomRoutineOverviewPage(level: 'iniciante'),
        ),
      );
      // Let the Future inside initState complete
      await tester.pump();
      await tester.pump();

      // Check that 6 green checkmark icons are shown
      expect(find.byIcon(Icons.check_circle), findsNWidgets(6));

      // Start button is now enabled
      final startButtonFinder = find.widgetWithText(CustomSolidButton, 'COMEÇAR');
      final startButton = tester.widget<CustomSolidButton>(startButtonFinder);
      expect(startButton.onPressed, isNotNull);
    });
  });

  group('CategorySelectionView Tests', () {
    testWidgets('renders category selection view with exercises and checkboxes', (tester) async {
      await customVM.initRoutine('iniciante');

      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CategorySelectionView(
            categoryTitle: 'Mobilidade',
            categoryKey: 'mobilidade',
          ),
        ),
      );
      await tester.pump();

      // Check category prompt
      expect(
        find.text('Selecione 2 exercícios de mobilidade:'),
        findsOneWidget,
      );

      // Check that mock exercises are rendered
      expect(find.text('Círculos com a perna'), findsOneWidget);
      expect(find.text('Círculos com o tornozelo'), findsOneWidget);
      expect(find.text('Pernas para frente e para trás'), findsOneWidget);

      // Checkboxes are initially unchecked
      final checkboxes = tester.widgetList<Checkbox>(find.byType(Checkbox));
      expect(checkboxes.length, equals(5)); // mobilidade has 5 mock exercises
      for (var checkbox in checkboxes) {
        expect(checkbox.value, isFalse);
      }

      // Proximo button is present and active
      final nextButtonFinder = find.widgetWithText(CustomSolidButton, 'PRÓXIMO');
      expect(nextButtonFinder, findsOneWidget);
      final nextButton = tester.widget<CustomSolidButton>(nextButtonFinder);
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('toggling a checkbox updates the selection state', (tester) async {
      await customVM.initRoutine('iniciante');

      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CategorySelectionView(
            categoryTitle: 'Mobilidade',
            categoryKey: 'mobilidade',
          ),
        ),
      );
      await tester.pump();

      // Tap on the first exercise list item/row to toggle selection
      await tester.tap(find.text('Círculos com a perna'));
      await tester.pump();

      // Verify it is selected in the view model
      expect(customVM.isExerciseSelected('mobilidade', 1001), isTrue);

      // Verify the UI checkbox updates
      final firstCheckboxFinder = find.byType(Checkbox).first;
      final checkbox = tester.widget<Checkbox>(firstCheckboxFinder);
      expect(checkbox.value, isTrue);
    });
  });
}

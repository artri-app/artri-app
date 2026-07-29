import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget _createTestApp({
  required CustomRoutineAdvancedViewModel advancedVM,
  required PhysicalExercisesViewModel physicalVM,
  required Widget child,
}) {
  return MaterialApp(
    home: Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomRoutineAdvancedViewModel>.value(value: advancedVM),
          ChangeNotifierProvider<PhysicalExercisesViewModel>.value(value: physicalVM),
        ],
        child: child,
      ),
    ),
  );
}

void main() {
  late CustomRoutineAdvancedViewModel advancedVM;
  late PhysicalExercisesViewModel physicalVM;

  setUpAll(() async {
    await dotenv.load();
  });

  setUp(() {
    advancedVM = CustomRoutineAdvancedViewModel();
    physicalVM = PhysicalExercisesViewModel(PhysicalExercisesService());
  });

  group('CustomRoutineAdvancedPage Tests', () {
    testWidgets('renders all default components and all exercises initially', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          advancedVM: advancedVM,
          physicalVM: physicalVM,
          child: const CustomRoutineAdvancedPage(),
        ),
      );
      await tester.pump();

      // Check title and descriptions
      expect(find.text('Personalizados Avançado'), findsOneWidget);
      expect(
        find.textContaining('Selecione os exercícios que deseja incluir'),
        findsOneWidget,
      );

      // Check search input field exists
      expect(find.byType(TextField), findsOneWidget);

      // Check default Category chips are rendered
      expect(find.text('Todos'), findsOneWidget);
      expect(find.text('Mobilidade'), findsOneWidget);
      expect(find.text('Aquecimento'), findsOneWidget);
      expect(find.text('Alongamento'), findsOneWidget);

      // Verify some default exercises from different categories are visible
      expect(find.text('Círculos com a perna'), findsOneWidget); // Mobilidade
      expect(find.text('Polichinelos adaptados'), findsOneWidget); // Aquecimento
      expect(find.text('Alongamento de posterior de coxa'), findsOneWidget); // Alongamento

      // Start button is disabled initially with count 0
      final startButtonFinder = find.widgetWithText(CustomSolidButton, 'INICIAR TREINO (0)');
      expect(startButtonFinder, findsOneWidget);
      final startButton = tester.widget<CustomSolidButton>(startButtonFinder);
      expect(startButton.onPressed, isNull);
    });

    testWidgets('filtering exercises by search query text input', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          advancedVM: advancedVM,
          physicalVM: physicalVM,
          child: const CustomRoutineAdvancedPage(),
        ),
      );
      await tester.pump();

      // Enter search query "tornozelo"
      await tester.enterText(find.byType(TextField), 'tornozelo');
      await tester.pump();

      // Verify only specific exercise is shown
      expect(find.text('Círculos com o tornozelo'), findsOneWidget);
      expect(find.text('Círculos com a perna'), findsNothing);
      expect(find.text('Polichinelos adaptados'), findsNothing);
    });

    testWidgets('filtering exercises by tapping category chip', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          advancedVM: advancedVM,
          physicalVM: physicalVM,
          child: const CustomRoutineAdvancedPage(),
        ),
      );
      await tester.pump();

      // Tap on "Alongamento" category chip
      final chipFinder = find.text('Alongamento');
      await tester.ensureVisible(chipFinder);
      await tester.tap(chipFinder);
      await tester.pump();

      // Verify alongamento exercises are visible but others are hidden
      expect(find.text('Alongamento de posterior de coxa'), findsOneWidget);
      expect(find.text('Círculos com a perna'), findsNothing);
      expect(find.text('Polichinelos adaptados'), findsNothing);
    });

    testWidgets('toggling checkboxes increments selection count and activates button', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          advancedVM: advancedVM,
          physicalVM: physicalVM,
          child: const CustomRoutineAdvancedPage(),
        ),
      );
      await tester.pump();

      // Tap first exercise
      final firstExerciseFinder = find.text('Círculos com a perna');
      await tester.ensureVisible(firstExerciseFinder);
      await tester.tap(firstExerciseFinder);
      await tester.pump();

      // Tap second exercise
      final secondExerciseFinder = find.text('Polichinelos adaptados');
      await tester.ensureVisible(secondExerciseFinder);
      await tester.tap(secondExerciseFinder);
      await tester.pump();

      // Verify selected count is 2 in viewModel
      expect(advancedVM.selectedCount, equals(2));
      expect(advancedVM.isExerciseSelected(1001), isTrue);
      expect(advancedVM.isExerciseSelected(2001), isTrue);

      // Verify button now displays "INICIAR TREINO (2)" and is active
      final startButtonFinder = find.widgetWithText(CustomSolidButton, 'INICIAR TREINO (2)');
      expect(startButtonFinder, findsOneWidget);
      final startButton = tester.widget<CustomSolidButton>(startButtonFinder);
      expect(startButton.onPressed, isNotNull);
    });
  });
}

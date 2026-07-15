import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

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
    customVM = CustomRoutineViewModel();
    physicalVM = PhysicalExercisesViewModel(PhysicalExercisesService());
  });

  group('CustomRoutineOverviewPage Tests', () {
    testWidgets('renders overview page title description and list of categories', (tester) async {
      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CustomRoutineOverviewPage(),
        ),
      );
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
      for (var cat in customVM.categories) {
        final exercises = customVM.getExercisesForCategory(cat.key);
        customVM.toggleExercise(cat.key, exercises[0].id);
        customVM.toggleExercise(cat.key, exercises[1].id);
      }

      await tester.pumpWidget(
        _createTestApp(
          customVM: customVM,
          physicalVM: physicalVM,
          child: const CustomRoutineOverviewPage(),
        ),
      );
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
        find.text('Selecione 2 exercícios de mobilidade das opções abaixo:'),
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

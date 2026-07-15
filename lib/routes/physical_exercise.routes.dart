import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalExerciseRoutes implements RoutesSession {
  static final String _base = ExerciseOptionsRoutes.physicalExercise;
  static String handExercises = '$_base/hand';
  static String feetExercises = '$_base/feet';
  static String customExercises = '$_base/custom';
  static String congratulations = '$_base/congratulations';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'congratulations',
          builder: (context, state) => CongratulationsView(),
        ),
        // Mãos
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'hand',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Mãos',
            child: const LevelExerciseSelector(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'hand/:difficulty',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Mãos',
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
            child: const PhysicalExerciseRoutineOverview(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'hand/:difficulty/:exerciseId',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Mãos',
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
            child: ExerciseRoutineStepView(
              key: ValueKey(state.pathParameters['exerciseId']),
            ),
          ),
        ),
        // Pés
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'feet',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Pés',
            child: const LevelExerciseSelector(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'feet/:difficulty',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Pés',
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
            child: const PhysicalExerciseRoutineOverview(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'feet/:difficulty/:exerciseId',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Pés',
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
            child: ExerciseRoutineStepView(
              key: ValueKey(state.pathParameters['exerciseId']),
            ),
          ),
        ),
        // Personalizado
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Personalizado',
            child: const LevelExerciseSelector(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/:difficulty',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Personalizado',
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
            child: const PhysicalExerciseRoutineOverview(),
          ),
        ),
        // Personalizado (Custom Routine)
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: '/custom_routine/overview',
          builder: (context, state) => const PhysicalExerciseView(
            title: 'Personalizado',
            child: CustomRoutineOverviewPage(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: '/custom_routine/overview/:exerciseId',
          builder: (context, state) => PhysicalExerciseView(
            title: 'Personalizado',
            child: ExerciseRoutineStepView(
              key: ValueKey(state.pathParameters['exerciseId']),
            ),
          ),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: '/custom_routine/select',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return PhysicalExerciseView(
              title: 'Personalizado',
              child: CategorySelectionView(
                categoryTitle: extra['title'] as String,
                categoryKey: extra['key'] as String,
              ),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: '/custom_routine/advanced',
          builder: (context, state) => const PhysicalExerciseView(
            title: 'Personalizado',
            child: CustomRoutineAdvancedPage(),
          ),
        ),
      ];
}

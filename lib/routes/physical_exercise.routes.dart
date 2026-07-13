import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/personalize_exercise_routine/custom_exercises_confirmation_page.dart';
import 'package:artriapp/views/personalize_exercise_routine/custom_exercises_level_selector.dart';
import 'package:artriapp/views/personalize_exercise_routine/personalize_exercise_routine.dart';
import 'package:artriapp/views/personalize_exercise_routine/select_exercises.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalExerciseRoutes implements RoutesSession {
  static final String _base = ExerciseOptionsRoutes.physicalExercise;
  static String handExercises = '$_base/hand';
  static String feetExercises = '$_base/feet';
  static String congratulations = '$_base/congratulations';
  static final String _customExercisesbase = '$_base/custom';
  static String customExercises = '$_customExercisesbase/description';
  static String selectCustomExercisesDifficulty = '$_customExercisesbase/select-difficulty';
  static String selectExercises = '$_customExercisesbase/select-exercise';
  static String confirmationRoute = '$_customExercisesbase/confirmation';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/description',
          builder: (context, state) => PersonalizeExerciseRoutine(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/select-exercise',
          builder: (context, state) => SelectExercises(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'congratulations',
          builder: (context, state) => CongratulationsView(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/select-difficulty',
          builder: (context, state) => CustomExerciseDifficultySelector(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/confirmation',
          builder: (context, state) => CustomExercisesConfirmationPage(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'custom/confirmation/:exerciseId',
          builder: (context, state) => ExerciseRoutineStepView(
            key: ValueKey(state.pathParameters['exerciseId']),
          ),
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Mãos',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'hand',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                  routes: [
                    GoRoute(
                      path: ':exerciseId',
                      builder: (context, state) => ExerciseRoutineStepView(
                        key: ValueKey(state.pathParameters['exerciseId']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Pés',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'feet',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                  routes: [
                    GoRoute(
                      path: ':exerciseId',
                      builder: (context, state) => ExerciseRoutineStepView(
                        key: ValueKey(state.pathParameters['exerciseId']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'EXERCÍCIOS PERSONALIZADOS',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'custom',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':exerciseId',
                  builder: (context, state) => ExerciseRoutineStepView(
                    key: ValueKey(state.pathParameters['exerciseId']),
                  ),
                ),
              ],
            ),
          ],
        ),
      ];
}

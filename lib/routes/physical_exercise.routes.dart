import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/exercise_routine_overview/exercise_routine_overview.view.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class PhysicalExerciseRoutes implements RoutesSession {
  static const String physicalExercises = '/exercise/physical-exercise';
  static const String handExercises = '$physicalExercises/hand';
  static const String feetExercises = '$physicalExercises/feet';
  static const String customExercises = '$physicalExercises/custom';

  static List<RouteBase> getGoRoutes() => [
        ShellRoute(
          pageBuilder: (context, state, child) => noneTransitionPage(
            context: context,
            state: state,
            child: ClearScaffoldView(child: child),
          ),
          routes: [
            ShellRoute(
              pageBuilder: (context, state, child) => noneTransitionPage(
                context: context,
                state: state,
                child: TypePhysicalExercise(
                  title: 'Mãos',
                  child: child,
                  subtitle: DifficultyHelper.getDifficultyText(
                      state.pathParameters['difficulty']),
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
                          const ExerciseRoutineOverviewView(),
                    ),
                  ],
                ),
              ],
            ),
            ShellRoute(
              pageBuilder: (context, state, child) => noneTransitionPage(
                context: context,
                state: state,
                child: TypePhysicalExercise(
                  title: 'Pés',
                  child: child,
                  subtitle: DifficultyHelper.getDifficultyText(
                      state.pathParameters['difficulty']),
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
                          const ExerciseRoutineOverviewView(),
                    ),
                  ],
                ),
              ],
            ),
            ShellRoute(
              pageBuilder: (context, state, child) => noneTransitionPage(
                context: context,
                state: state,
                child: TypePhysicalExercise(
                  title: 'Personalizado',
                  child: child,
                  subtitle: DifficultyHelper.getDifficultyText(
                      state.pathParameters['difficulty']),
                ),
              ),
              routes: [
                GoRoute(
                  path: 'custom',
                  builder: (context, state) => const LevelExerciseSelector(),
                  routes: [
                    GoRoute(
                      path: ':difficulty',
                      builder: (context, state) =>
                          const ExerciseRoutineOverviewView(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}

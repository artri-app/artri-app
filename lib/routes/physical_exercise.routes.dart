import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:go_router/go_router.dart';

class PhysicalExerciseRoutes implements RoutesSession {
  static final String _base = ExerciseOptionsRoutes.physicalExercise;
  static String handExercises = '$_base/hand';
  static String feetExercises = '$_base/feet';
  static String customExercises = '$_base/custom';

  static List<RouteBase> getGoRoutes() => [
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
                      path: ':id',
                      builder: (context, state) => ExerciseRoutineStepView(
                        exerciseId:
                            int.parse(state.pathParameters['id'] ?? '-1'),
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
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Personalizado',
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
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                ),
              ],
            ),
          ],
        ),
      ];
}

import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class ExerciseRoutes implements RoutesSession {
  static const String physicalExercises = '/physical-exercise';
  static const String handExercises = '$physicalExercises/hand';
  static const String feetExercises = '$physicalExercises/feet';
  static const String customExercises = '$physicalExercises/custom';
  static const String handExerciseRoutineStep = '$handExercises/step/:id';
  static const String feetExerciseRoutineStep = '$feetExercises/step/:id';
  static const String customExerciseRoutineStep = '$customExercises/step/:id';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: physicalExercises,
          builder: (context, state) => const PhysicalExerciseHomeView(),
          routes: [
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
                    child: TypePhysicalExercise(title: 'Mãos', child: child),
                  ),
                  routes: [
                    GoRoute(
                      path: 'hand',
                      builder: (context, state) =>
                          const LevelExerciseSelector(),
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
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: 'feet',
                      builder: (context, state) =>
                          const LevelExerciseSelector(),
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
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: 'custom',
                      builder: (context, state) =>
                          const LevelExerciseSelector(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}

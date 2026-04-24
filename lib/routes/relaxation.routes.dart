import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:go_router/go_router.dart';
import 'package:artriapp/views/relaxation/index.dart';

class RelaxationRoutes {
  static const String _relaxation = ExerciseOptionsRoutes.relaxation;

  static const String breathingTechniques = '$_relaxation/breathing';
  static const String guidedRelaxation = '$_relaxation/guided';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'breathing',
          builder: (context, state) => const BreathingTechniquesPage(),
          routes: [
            GoRoute(
              parentNavigatorKey: RouterKeys.appRoutesKey,
              path: 'audio',
              builder: (context, state) {
                final exercise = state.extra as Exercise;
                return RelaxationAudioPage(exercise: exercise);
              },
            ),
          ],
        ),
        GoRoute(
            parentNavigatorKey: RouterKeys.appRoutesKey,
            path: 'guided',
            builder: (context, state) => const GuidedRelaxationPage(),
            routes: [
              GoRoute(
                parentNavigatorKey: RouterKeys.appRoutesKey,
                path: 'audio',
                builder: (context, state) {
                  final exercise = state.extra as Exercise;
                  return RelaxationAudioPage(exercise: exercise);
                },
              ),
            ],),
      ];
}

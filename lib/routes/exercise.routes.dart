import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/physical_exercise.routes.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class ExerciseRoutes implements RoutesSession {
  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: 'physical-exercise',
          builder: (context, state) => const PhysicalExerciseHomeView(),
          routes: PhysicalExerciseRoutes.getGoRoutes(),
        ),
      ];
}

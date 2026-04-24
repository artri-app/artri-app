import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

abstract class LoggedRoutes implements RoutesSession {
  static List<RouteBase> getGoRoutes() => [
        ...BottomNavRoutes.getGoRoutes(),
        ...PhysicalExerciseRoutes.getGoRoutes(),
        GoRoute(
          path: RelaxationRoutes.relaxation,
          builder: (context, state) => const RelaxationPage(),
          routes: RelaxationRoutes.getGoRoutes(),
        ),
      ];
}

import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

abstract class LoggedRoutes implements RoutesSession {
  static const String remedy = '/remedy';

  static List<RouteBase> getGoRoutes() => [
        ...BottomNavRoutes.getGoRoutes(),
        ...PhysicalExerciseRoutes.getGoRoutes(),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: remedy,
          builder: (context, state) => const RemedyPage(),
        ),
      ];
}

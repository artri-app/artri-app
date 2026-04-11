import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:go_router/go_router.dart';

abstract class ExerciseOptionsRoutes implements RoutesSession {
  static const String _base = '/exercise';
  static const physicalExercise = '$_base/physical_exercise';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: 'physical_exercise',
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state) => PhysicalExerciseView(
            title: ('Exercícios físicos').toUpperCase(),
            child: PhysicalExerciseHome(),
          ),
          routes: PhysicalExerciseRoutes.getGoRoutes(),
        ),
      ];
}

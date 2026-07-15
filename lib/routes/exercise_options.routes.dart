import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/personalize_exercise_routine/personalize_exercise_routine.dart';
import 'package:go_router/go_router.dart';

abstract class ExerciseOptionsRoutes implements RoutesSession {
  static const String _base = '/exercise';
  static const physicalExercise = '$_base/physical_exercise';
  static const relaxation = '$_base/relaxation';
  static const infoAtividadeFisica = '$_base/info-atividade-fisica';
  static const personalizedExercise = '$_base/personalize-exercises';

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
        GoRoute(
          path: 'relaxation',
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state) => const RelaxationPage(),
          routes: RelaxationRoutes.getGoRoutes(),
        ),
        GoRoute(
          path: 'info-atividade-fisica',
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state) => const AtividadeFisicaInfoPage(),
        ),
      ];
}

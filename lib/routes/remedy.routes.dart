import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/remedy/add_remedy_page.dart';
import 'package:artriapp/views/remedy/remedy_page.dart';
import 'package:go_router/go_router.dart';

abstract class RemedyRoutes implements RoutesSession {
  static const String remedy = '/remedy';
  static const String addRemedy = '/add-remedy';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: remedy,
          builder: (context, state) => const RemedyPage(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: addRemedy,
          builder: (context, state) => AddRemedyPage(
            remedy: state.extra as Remedy?,
          ),
        ),
      ];
}

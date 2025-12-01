import 'package:artriapp/routes/app.routes.dart';
import 'package:artriapp/routes/user_diary.routes.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes implements RoutesSession {
  static const String diary = '/diary';
  static const String exercise = '/exercise';
  static const String info = '/info';
  static const String evolution = '/evolution';

  static List<RouteBase> getGoRoutes() => [
        ShellRoute(
          builder: (context, state, child) => LoggedPage(
            child: child,
          ),
          routes: [
            ShellRoute(
              builder: (context, state, child) => UserDiaryPage(
                child: child,
              ),
              routes: UserDiaryRoutes.getGoRoutes(),
            ),
            GoRoute(
              path: exercise,
              builder: (context, state) => const ExercisePage(),
            ),
            GoRoute(
              path: info,
              builder: (context, state) => const InfoPage(),
            ),
            GoRoute(
              path: evolution,
              builder: (context, state) => const InfoPage(),
            ),
          ],
        ),
      ];
}

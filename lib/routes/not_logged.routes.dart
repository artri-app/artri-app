import 'package:artriapp/routes/app.routes.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class NotLoggedRoutes implements RoutesSession {
  static const String login = '/login';
  static const String signUp = '/sign-up';

  static List<RouteBase> getGoRoutes() {
    return [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(title: 'ArtriApp'),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpPage(title: 'ArtriApp'),
      ),
    ];
  }
}

import 'package:artriapp/routes/app.routes.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class SettingsRoutes implements RoutesSession {
  static const String configuration = '/configuration';
  static const String changeEmail = '/change-email';
  static const String changePassword = '/change-password';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: configuration,
          builder: (context, state) => const ConfigPage(),
        ),
        GoRoute(
          path: changeEmail,
          builder: (context, state) => const ChangeEmailPage(),
        ),
        GoRoute(
          path: changePassword,
          builder: (context, state) => const ChangePasswordPage(),
        ),
      ];
}

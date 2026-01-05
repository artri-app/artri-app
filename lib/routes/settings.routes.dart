import 'package:artriapp/models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class SettingsRoutes implements RoutesSession {
  static const String changeEmail = 'configuration/change-email';
  static const String changePassword = 'configuration/change-password';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: "change-email",
          builder: (context, state) => const ChangeEmailPage(),
        ),
        GoRoute(
          path: "change-password",
          builder: (context, state) => const ChangePasswordPage(),
        ),
      ];
}

import 'package:artriapp/models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

abstract class SettingsRoutes implements RoutesSession {
  static const String changeEmail = '/diary/settings/change-email';
  static const String changePassword = '/diary/settings/change-password';

  static List<RouteBase> getGoRoutes() => [
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

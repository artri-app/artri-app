import "package:artriapp/views/index.dart";
import 'package:go_router/go_router.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/sign-up";
  static const String configuration = "/configuration";
  static const String changeEmail = "/change-email";
  static const String changePassword = "/change-password";
  static const String diary = "/diary";
  static const String loggedPage = "/loggedPage";

  static List<GoRoute> getGoRoutes() {
    return [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(title: 'ArtriApp'),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpPage(title: 'ArtriApp'),
      ),
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
      GoRoute(
        path: diary,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: loggedPage,
        builder: (context, state) => const LoggedPage(),
      ),
    ];
  }
}

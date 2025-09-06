import "package:artriapp/views/index.dart";
import 'package:flutter/material.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/sign-up";
  static const String configuration = "/configuration";
  static const String changeEmail = "/change-email";
  static const String changePassword = "/change-password";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(title: 'ArtriApp'),
      signUp: (context) => const SignUpPage(title: 'ArtriApp'),
      configuration: (context) => const ConfigPage(),
      changeEmail: (context) => const ChangeEmailPage(),
      changePassword: (context) => const ChangePasswordPage(),
    };
  }
}

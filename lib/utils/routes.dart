import 'package:artriapp/views/config/config_page.dart';
import 'package:artriapp/views/login_page/login_page.dart';
import 'package:artriapp/views/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/sign-up";
  static const String configuration = "/configuration";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(title: 'ArtriApp'),
      signUp: (context) => const SignUpPage(title: 'ArtriApp'),
      configuration: (context) => const ConfigPage(),
    };
  }
}

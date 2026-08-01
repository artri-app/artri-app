import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/services/security_token_service.dart';
import 'package:artriapp/utils/enums/security_tokens.dart';
import 'package:artriapp/views/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await SecurityTokenService().init();

  final refreshToken = await SecurityTokenService().getToken(SecurityToken.refreshToken);
  if (refreshToken != null && refreshToken.isNotEmpty) {
    try {
      final response = await AuthService().refreshAuthToken(refreshToken);
      await SecurityTokenService().saveToken(response.accessToken, SecurityToken.accessToken);
      await SecurityTokenService().saveToken(response.refreshToken, SecurityToken.refreshToken);
    } catch (_) {
      // Refresh failed - user will re-authenticate
    }
  }

  await NotificationService.instance.init();
  runApp(App());
}

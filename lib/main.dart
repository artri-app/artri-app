import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/views/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  final notificationService = NotificationService();
  await notificationService.init();

  runApp(App(notificationService: notificationService));
}

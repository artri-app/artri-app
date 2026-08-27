import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/calendar_page/calendar_page.dart';
import 'package:artriapp/views/calendar_page/new_reminder_page.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/remedy/remedy_page.dart';
import 'package:go_router/go_router.dart';

abstract class LoggedRoutes implements RoutesSession {
  static const String remedy = '/remedy';
  static const String agenda = '/agenda';
  static const String novoLembrete = '/lembrete';

  static List<RouteBase> getGoRoutes() => [
        ...BottomNavRoutes.getGoRoutes(),
        ...PhysicalExerciseRoutes.getGoRoutes(),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: remedy,
          builder: (context, state) => const RemedyPage(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: agenda,
          builder: (context, state) => const CalendarPage(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: novoLembrete,
          builder: (context, state) => const AddReminderPage(),
        ),
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: '/configuration',
          redirect: (context, state) => BottomNavRoutes.diary,
          routes: SettingsRoutes.getGoRoutes(),
        ),
      ];
}

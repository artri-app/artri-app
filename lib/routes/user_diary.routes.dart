import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

class UserDiaryRoutes implements RoutesSession {
  static const String diary = '/diary';
  static const String fatigueSelectionPage = '/fatigue-selection';
  static const String sleepSelectionPage = '/sleep-selection';
  static const String swellingSelectionPage = '/swelling-selection';
  static const String painSelectionPage = '/pain-selection';
  static const String settings = '/settings';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: diary,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: UserDiaryInitialSelection(),
          ),
        ),
        GoRoute(
          path: fatigueSelectionPage,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: const UserLevelSelection(
              title: 'Fadiga',
              tooltipMessage:
                  'É um cansaço intenso e constante e falta de energia, que não melhora mesmo após descanso e pode atrapalhar nas atividades do dia a dia',
              description: 'De 0 a 10, como esta seu nível de fadiga hoje?',
            ),
          ),
        ),
        GoRoute(
          path: painSelectionPage,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: UserLevelSelectionWithOptions(
              title: 'Dor',
            ),
          ),
        ),
        GoRoute(
          path: sleepSelectionPage,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: const UserLevelSelection(
              title: 'Sono',
              description: 'De 0 a 10, como esta seu nível de sono hoje?',
            ),
          ),
        ),
        GoRoute(
          path: swellingSelectionPage,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: UserLevelSelectionWithOptions(
              title: 'Inchaço',
              tooltipMessage:
                  'Inchaço é quando uma parte do corpo parece maior ou mais “cheia” do que o normal, como se estivesse acumulando líquido ou inflamada. A região inchada pode ficar mais dura, quente, avermelhada ou sensível ao toque.',
            ),
          ),
        ),
        GoRoute(
          path: settings,
          pageBuilder: (context, state) => noneTransitionPage(
            context: context,
            state: state,
            child: LoggedSettingsPage(),
          ),
        ),
      ];
}

import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:artriapp/views/info/data/alimentacao.dart';
import 'package:artriapp/views/info/data/leis_direitos.dart';
import 'package:artriapp/views/user_diary/widgets/index.dart';
import 'package:artriapp/views/user_diary/widgets/user_level_selection_with_options.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String configuration = '/configuration';
  static const String changeEmail = '/change-email';
  static const String changePassword = '/change-password';
  static const String diary = '/diary';
  static const String artriteInfoPage = '/artrite-info';
  static const String treatmentsInfoPage = '/treatments-info';
  static const String myPainInfoPage = '/my-pain-info';
  static const String sleepInfoPage = '/sleep-info';
  static const String foodRoutineInfoPage = '/food-routine-info';
  static const String lawsInfoPage = '/laws-info';
  static const String fatigueSelectionPage = '/fatigue-selection';
  static const String sleepSelectionPage = '/sleep-selection';
  static const String swellingSelectionPage = '/swelling-selection';
  static const String painSelectionPage = '/pain-selection';
  static const String exercise = '/exercise';
  static const String info = '/info';
  static const String evolution = '/evolution';

  static List<RouteBase> getGoRoutes() {
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
        path: artriteInfoPage,
        builder: (context, state) => const ArtriteReumatoideInfoPage(),
      ),
      GoRoute(
        path: treatmentsInfoPage,
        builder: (context, state) => const TratamentosInfoPage(),
      ),
      GoRoute(
        path: myPainInfoPage,
        builder: (context, state) => const MinhaDorInfoPage(),
      ),
      GoRoute(
        path: sleepInfoPage,
        builder: (context, state) => const SonoInfoPage(),
      ),
      GoRoute(
        path: foodRoutineInfoPage,
        builder: (context, state) => const AlimentacaoInfoPage(),
      ),
      GoRoute(
        path: lawsInfoPage,
        builder: (context, state) => const LeisDireitosInfoPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => LoggedPage(
          child: child,
        ),
        routes: [
          ShellRoute(
            builder: (context, state, child) => UserDiaryPage(
              child: child,
            ),
            routes: [
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
                    description:
                        'De 0 a 10, como esta seu nível de fadiga hoje?',
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
            ],
          ),
          GoRoute(
            path: exercise,
            builder: (context, state) => const ExercisePage(),
          ),
          GoRoute(
            path: info,
            builder: (context, state) => const InfoPage(),
          ),
          GoRoute(
            path: evolution,
            builder: (context, state) => const InfoPage(),
          ),
        ],
      ),
    ];
  }
}

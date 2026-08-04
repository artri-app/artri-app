import 'package:artriapp/models/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:go_router/go_router.dart';

abstract class UserDiaryRoutes implements RoutesSession {
  static const String diary = '/diary';
  static const String fatigueSelectionPage = '$diary/fatigue-selection';
  static const String sleepSelectionPage = '$diary/sleep-selection';
  static const String swellingSelectionPage = '$diary/swelling-selection';
  static const String painSelectionPage = '$diary/pain-selection';
  static const String settings = '$diary/settings';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: diary,
          pageBuilder: (context, state) => NoTransitionPage(
            child: UserDiaryInitialSelection(),
          ),
          routes: [
            GoRoute(
              path: 'fatigue-selection',
              pageBuilder: (context, state) => NoTransitionPage(
                child: UserLevelSelection(
                  title: DiaryOptions.fatigue.toString(),
                  metric: DiaryMetric.fatigue,
                  tooltipTitle: 'O que é fadiga?',
                  tooltipMessage:
                      'É um cansaço intenso e constante e falta de energia, que não melhora mesmo após descanso e pode atrapalhar nas atividades do dia a dia.',
                  description: 'De 0 a 10, como esta seu nível de fadiga hoje?',
                  minLabel: 'Nenhuma',
                  maxLabel: 'Intensa',
                ),
              ),
            ),
            GoRoute(
              path: 'pain-selection',
              pageBuilder: (context, state) => NoTransitionPage(
                child: UserLevelSelectionWithOptions(
                  title: DiaryOptions.pain.toString(),
                  metric: DiaryMetric.pain,
                  tooltipTitle: 'O que é dor?',
                  tooltipMessage:
                      'Dor é uma sensação desagradável que o corpo usa para avisar que algo precisa de atenção. Na artrite reumatoide ela aparece com mais frequência nas juntas, junto com rigidez, e pode mudar de intensidade ao longo do dia. Marque as regiões em que você sentiu dor hoje.',
                ),
              ),
            ),
            GoRoute(
              path: 'sleep-selection',
              pageBuilder: (context, state) => NoTransitionPage(
                child: UserLevelSelection(
                  title: DiaryOptions.sleep.toString(),
                  metric: DiaryMetric.sleep,
                  tooltipTitle: 'Como avaliar o seu sono?',
                  tooltipMessage:
                      'Pense em como você dormiu na última noite: se demorou para pegar no sono, se acordou várias vezes e se o descanso foi suficiente para você acordar com energia. Quanto melhor o seu sono, mais perto de 10.',
                  description: 'De 0 a 10, como esta seu nível de sono hoje?',
                  minLabel: 'Ruim',
                  maxLabel: 'Ótimo',
                ),
              ),
            ),
            GoRoute(
              path: 'swelling-selection',
              pageBuilder: (context, state) => NoTransitionPage(
                child: UserLevelSelectionWithOptions(
                  title: DiaryOptions.swelling.toString(),
                  metric: DiaryMetric.swelling,
                  tooltipTitle: 'O que é inchaço?',
                  tooltipMessage:
                      'Inchaço é quando uma parte do corpo parece maior ou mais “cheia” do que o normal, como se estivesse acumulando líquido ou inflamada. A região inchada pode ficar mais dura, quente, avermelhada ou sensível ao toque.',
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: settings,
          pageBuilder: (context, state) => NoTransitionPage(
            child: LoggedSettingsPage(),
          ),
        ),
      ];
}

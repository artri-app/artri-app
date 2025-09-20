import "package:artriapp/views/index.dart";
import 'package:artriapp/views/info/data/alimentacao.dart';
import 'package:artriapp/views/info/data/leis_direitos.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/sign-up";
  static const String configuration = "/configuration";
  static const String changeEmail = "/change-email";
  static const String changePassword = "/change-password";
  static const String diary = "/diary";
  static const String loggedPage = "/loggedPage";
  static const String sleepPage = "/sleep";
  static const String fatiguePage = "/fatigue";
  static const String painPage = "/pain";
  static const String artriteInfoPage = "/artrite-info";
  static const String tratamentosInfoPage = "/tratamentos-info";
  static const String minhaDorInfoPage = "/minha-dor-info";
  static const String sonoInfoPage = "/sono-info";
  static const String alimentacaoInfoPage = "/alimentacao-info";
  static const String leisDireitosInfoPage = "/leis-direitos-info";

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
      GoRoute(
        path: sleepPage,
        builder: (context, state) => const SleepPage(),
      ),
      GoRoute(
        path: fatiguePage,
        builder: (context, state) => const FatiguePage(),
      ),
      GoRoute(
        path: painPage,
        builder: (context, state) => const PainPage(),
      ),
      GoRoute(
        path: artriteInfoPage,
        builder: (context, state) => const ArtriteReumatoideInfoPage(),
      ),
      GoRoute(
        path: tratamentosInfoPage,
        builder: (context, state) => const TratamentosInfoPage(),
      ),
      GoRoute(
        path: minhaDorInfoPage,
        builder: (context, state) => const MinhaDorInfoPage(),
      ),
      GoRoute(
        path: sonoInfoPage,
        builder: (context, state) => const SonoInfoPage(),
      ),
      GoRoute(
        path: alimentacaoInfoPage,
        builder: (context, state) => const AlimentacaoInfoPage(),
      ),
      GoRoute(
        path: leisDireitosInfoPage,
        builder: (context, state) => const LeisDireitosInfoPage(),
      ),
    ];
  }
}

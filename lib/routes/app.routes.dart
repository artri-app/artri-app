import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/routes/logged.routes.dart';
import 'package:go_router/go_router.dart';

class AppRoutes implements RoutesSession {
  static const String artriteInfoPage = '/artrite-info';
  static const String treatmentsInfoPage = '/treatments-info';
  static const String myPainInfoPage = '/my-pain-info';
  static const String sleepInfoPage = '/sleep-info';
  static const String foodRoutineInfoPage = '/food-routine-info';
  static const String lawsInfoPage = '/laws-info';

  static List<RouteBase> getGoRoutes() {
    return [
      ...NotLoggedRoutes.getGoRoutes(),
      ...LoggedRoutes.getGoRoutes(),
      // GoRoute(
      //   path: artriteInfoPage,
      //   builder: (context, state) => const ArtriteReumatoideInfoPage(),
      // ),
      // GoRoute(
      //   path: treatmentsInfoPage,
      //   builder: (context, state) => const TratamentosInfoPage(),
      // ),
      // GoRoute(
      //   path: myPainInfoPage,
      //   builder: (context, state) => const MinhaDorInfoPage(),
      // ),
      // GoRoute(
      //   path: sleepInfoPage,
      //   builder: (context, state) => const SonoInfoPage(),
      // ),
      // GoRoute(
      //   path: foodRoutineInfoPage,
      //   builder: (context, state) => const AlimentacaoInfoPage(),
      // ),
      // GoRoute(
      //   path: lawsInfoPage,
      //   builder: (context, state) => const LeisDireitosInfoPage(),
      // ),
    ];
  }
}

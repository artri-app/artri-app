import 'package:artriapp/models/route_session.dart';
import 'package:artriapp/views/info/emocional.dart';
import 'package:artriapp/views/info/exercicio_fisico.dart';
import 'package:artriapp/views/info/mitos_verdades.dart';
import 'package:go_router/go_router.dart';
import 'package:artriapp/views/info/artrite_reumatoide.dart';
import 'package:artriapp/views/info/tratamentos.dart';
import 'package:artriapp/views/info/minha_dor.dart';
import 'package:artriapp/views/info/sono.dart';
import 'package:artriapp/views/info/alimentacao.dart';
import 'package:artriapp/views/info/leis_direitos.dart';

class InfoRoutes implements RoutesSession {
  static List<RouteBase> getGoRoutes() {
    return [
      GoRoute(
        path: 'artrite',
        builder: (context, state) => const ArtriteInfoPage(),
      ),
      GoRoute(
        path: 'tratamentos',
        builder: (context, state) => const TratamentosInfoPage(),
      ),
      GoRoute(
        path: 'minha-dor',
        builder: (context, state) => const MinhaDorInfoPage(),
      ),
      GoRoute(
        path: 'sono',
        builder: (context, state) => const SonoInfoPage(),
      ),
      GoRoute(
        path: 'alimentacao',
        builder: (context, state) => const AlimentacaoInfoPage(),
      ),
      GoRoute(
        path: 'emocional',
        builder: (context, state) => const EmocionalInfoPage(),
      ),
      GoRoute(
        path: 'exercicio',
        builder: (context, state) => const ExercicioInfoPage(),
      ),
      GoRoute(
        path: 'leis',
        builder: (context, state) => const LeisDireitosInfoPage(),
      ),
      GoRoute(
        path: 'mitos-verdades',
        builder: (context, state) => const MitosVerdadesInfoPage(),
      ),
    ];
  }
}

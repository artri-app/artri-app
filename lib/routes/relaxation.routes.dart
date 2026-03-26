import 'package:go_router/go_router.dart';
import 'package:artriapp/views/relaxation/breathing_page.dart';
import 'package:artriapp/views/relaxation/guided_relaxation_page.dart';
import 'package:artriapp/views/relaxation/relaxation_audio_page.dart';

class RelaxationRoutes {
  static const String relaxation = '/relaxation';

  static const String breathingTechniques = 'breathing';
  static const String guidedRelaxation = 'guided';
  static const String audioPage = 'audio';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          path: breathingTechniques,
          builder: (context, state) => const BreathingTechniquesPage(),
        ),
        GoRoute(
          path: guidedRelaxation,
          builder: (context, state) => const GuidedRelaxationPage(),
        ),
        GoRoute(
          path: audioPage,
          builder: (context, state) {
            final name = state.extra as String;
            return RelaxationAudioPage(audioName: name);
          },
        ),
      ];
}

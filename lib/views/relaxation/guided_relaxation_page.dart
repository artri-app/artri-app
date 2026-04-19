//import 'package:artriapp/routes/relaxation.routes.dart';
import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/models/api_responses/training.dart';
import 'package:artriapp/services/training_service.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/views/relaxation/widget/relaxation_tile.dart';
import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// A page widget for guided relaxation exercises in the app.
///
/// This [StatefulWidget] displays a guided relaxation session by loading
/// exercises from a training that matches 'relaxamento' in its name, or
/// defaults to the first available training if none match. It uses
/// [TrainingService] to fetch trainings and exercises asynchronously.
///
/// The [_GuidedRelaxationPageState] manages the state, initializing the
/// service and a future that loads the relevant exercises in [initState].
/// The [_loadGuidedExercises] method performs the async loading: it waits
/// for both trainings and exercises, finds the appropriate training, and
/// filters exercises belonging to it.
class GuidedRelaxationPage extends StatefulWidget {
  const GuidedRelaxationPage({super.key});

  @override
  State<GuidedRelaxationPage> createState() => _GuidedRelaxationPageState();
}

class _GuidedRelaxationPageState extends State<GuidedRelaxationPage> {
  late final TrainingService _service;
  late final Future<List<Exercise>> _guidedExercisesFuture;

  @override
  void initState() {
    super.initState();
    _service = TrainingService();
    _guidedExercisesFuture = _loadGuidedExercises();
  }

  Future<List<Exercise>> _loadGuidedExercises() async {
    final results = await Future.wait([
      _service.getTrainings(),
      _service.getExercises(),
    ]);

    final trainings = results[0] as List<Training>;
    final exercises = results[1] as List<Exercise>;

    if (trainings.isEmpty) return [];

    Training? guidedTraining;
    for (final training in trainings) {
      if (training.name.toLowerCase().contains('relaxamento')) {
        guidedTraining = training;
        break;
      }
    }

    // check if guidedTraining is null, if it is, assign the first training to it
    guidedTraining ??= trainings.first;

    // return the exercises that belong to the guidedTraining, sorted by the order they appear in the training
    final list = exercises
        .where((exercise) => guidedTraining!.exercises.contains(exercise.id))
        .toList();

// 🔥 ORDENA PELO NOME
    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: 'RELAXAMENTO GUIADO',
            size: 36,
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: AppColors.darkGreen,
                ),
              ),
              children: const [
                TextSpan(text: 'O '),
                TextSpan(
                  text: 'relaxamento guiado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' por meio de áudios é uma técnica simples que ajuda a acalmar o corpo e a mente. Pode ajudar a reduzir o estresse, aliviar dores, melhorar o sono e aumentar a sensação de bem-estar.',
                ),
              ],
            ),
          ),
          Text(
            'Escolha um vídeo abaixo e experimente!',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.darkGreen,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: FutureBuilder<List<Exercise>>(
              future: _guidedExercisesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao carregar os vídeos.'),
                  );
                }

                final exercises = snapshot.data ?? [];

                if (exercises.isEmpty) {
                  return const Center(
                    child: Text('Nenhum vídeo encontrado para esta categoria.'),
                  );
                }

                return Scrollbar(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];

                      // return a list of relaxation tiles with the exercise name and video link
                      return RelaxationTile(
                        title: exercise.name,
                        videoUrl: exercise.link,
                        onTap: () => context.push(
                          '/relaxation/audio',
                          extra: exercise,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

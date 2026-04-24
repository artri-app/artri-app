//import 'package:artriapp/routes/relaxation.routes.dart';
import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/models/api_responses/training.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/services/training_service.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/views/relaxation/widget/relaxation_tile.dart';
import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// A page that displays breathing techniques exercises.
///
/// This stateful widget loads breathing-related exercises from the TrainingService.
/// It fetches trainings and exercises asynchronously, filters for breathing trainings,
/// and displays the associated exercises. If no specific breathing training is found,
/// it defaults to the first available training.
class BreathingTechniquesPage extends StatefulWidget {
  const BreathingTechniquesPage({super.key});

  @override
  State<BreathingTechniquesPage> createState() =>
      _BreathingTechniquesPageState();
}

class _BreathingTechniquesPageState extends State<BreathingTechniquesPage> {
  late final TrainingService _service;
  late final Future<List<Exercise>> _breathingExercisesFuture;

  @override
  void initState() {
    super.initState();
    _service = TrainingService();
    _breathingExercisesFuture = _loadBreathingExercises();
  }

  Future<List<Exercise>> _loadBreathingExercises() async {
    final results = await Future.wait([
      _service.getTrainings(),
      _service.getExercises(),
    ]);

    final trainings = results[0] as List<Training>;
    final exercises = results[1] as List<Exercise>;

    if (trainings.isEmpty) return [];

    Training? breathingTraining;
    for (final training in trainings) {
      if (training.name.toLowerCase().contains('respiração')) {
        breathingTraining = training;
        break;
      }
    }

    // check if breathingTraining is null, if it is, assign the first training to it
    breathingTraining ??= trainings.first;

    return exercises
        .where((exercise) => breathingTraining!.exercises.contains(exercise.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: 'TÉCNICAS DE RESPIRAÇÃO',
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
                TextSpan(text: 'As '),
                TextSpan(
                  text: 'técnicas de respiração',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' são exercícios simples que ajudam a controlar o ritmo da respiração. Podem ser usadas no dia a dia para aliviar o estresse, melhorar a concentração e reduzir a tensão muscular. Respirar de forma consciente também ajuda no relaxamento físico e mental, sendo útil em momentos de dor, ansiedade ou cansaço.',
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
              future: _breathingExercisesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}'),
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
                        onTap: () => context.go(
                          '${RelaxationRoutes.breathingTechniques}/audio',
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

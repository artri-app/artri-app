import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/enums/exercise_difficulty.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseRoutineStepView extends StatelessWidget {
  const ExerciseRoutineStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        var exercise = viewModel.currentExercise;

        var videoController = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(
                exercise!.tutorialLink,
              ) ??
              'IxX_QHay02M',
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            controlsVisibleAtStart: true,
          ),
        );
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              spacing: 16,
              children: [
                  Text((viewModel.currentDifficulty ?? ExerciseDifficulty.easy).toTitleName(),
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: AppColors.mediumGreen,
                  ),
                ),
                YoutubePlayer(controller: videoController),
                SessionTitle(title: exercise.name.split('-').first.trim()),
                ExerciseSetProperties(
                  details: exercise.details,
                ),
                ExerciseSetDetails(
                  exerciseDescription: exercise.description,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

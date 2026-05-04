import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
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
                exercise!.link,
              ) ??
              'IxX_QHay02M',
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            controlsVisibleAtStart: true,
          ),
        );
        return Column(
          spacing: 16,
          children: [
            YoutubePlayer(controller: videoController),
            SessionTitle(title: exercise.name.split('-').first.trim()),
            ExerciseSetProperties(),
            ExerciseSetDetails(),
          ],
        );
      },
    );
  }
}

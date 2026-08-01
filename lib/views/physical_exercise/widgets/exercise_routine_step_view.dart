import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseRoutineStepView extends StatelessWidget {
  const ExerciseRoutineStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        final exercise = viewModel.currentExercise;
        if (exercise == null) return const SizedBox.shrink();

        final videoController = YoutubePlayerController.fromVideoId(
          videoId: YoutubePlayerController.convertUrlToId(
                exercise.tutorialLink,
              ) ??
              'IxX_QHay02M',
          autoPlay: false,
        );
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              spacing: 16,
              children: [
                VideoPlayerWidget(
                  videoUrl: exercise.tutorialLink,
                ),
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

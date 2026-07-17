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
        var exercise = viewModel.currentExercise;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              spacing: 16,
              children: [
                VideoPlayerWidget(
                  videoUrl: exercise!.tutorialLink,
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

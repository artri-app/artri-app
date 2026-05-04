import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhysicalExerciseRoutineOverview extends StatefulWidget {
  const PhysicalExerciseRoutineOverview({super.key});

  @override
  State<PhysicalExerciseRoutineOverview> createState() =>
      _PhysicalExerciseRoutineOverviewState();
}

class _PhysicalExerciseRoutineOverviewState
    extends State<PhysicalExerciseRoutineOverview> {
  bool orientationsOpen = false;

  void handleStartButton(
    BuildContext context,
    PhysicalExercisesViewModel viewModel,
  ) {
    if (orientationsOpen) {
      setState(() => orientationsOpen = false);
      viewModel.handleStartExercises(context);
      return;
    }

    setState(() => orientationsOpen = true);
    showDialog(
      builder: (context) => OrientationsDialog(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        int exerciseCount = viewModel.exercises.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              'Você levará aproximadamente x minutos para realizar os exercícios',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 22,
                color: AppColors.darkGreen,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: exerciseCount,
                  itemBuilder: (context, index) => ExerciseTile(
                    exerciseName:
                        viewModel.exercises[index].name.split('-').first,
                  ),
                ),
              ),
            ),
            CustomSolidButton(
              text: 'Começar'.toUpperCase(),
              onPressed: () => handleStartButton(context, viewModel),
              gradientColors: AppGradients.greenGradient,
              textStyle: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}

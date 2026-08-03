import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class PhysicalExerciseRoutineOverview extends StatelessWidget {
  const PhysicalExerciseRoutineOverview({super.key});

  Future<void> handleStartButton(
    BuildContext context,
    PhysicalExercisesViewModel viewModel,
  ) async {
    bool startExercises = await showDialog(
      builder: (context) => OrientationsDialog(),
      context: context,
    );

    if (startExercises) viewModel.handleStartExercises(context);
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
              'Resumo da sessão',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: AppColors.darkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Abaixo está um resumo da sua sessão de exercícios, para iniciar clique no botão abaixo, para ler as instruções antes de iniciar os exercícios.',
              style: GoogleFonts.montserrat(fontSize: 20),
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
                    customIcon: CupertinoIcons.play_arrow_solid,
                  ),
                ),
              ),
            ),
            CustomSolidButton(
              text: 'Começar'.toUpperCase(),
              onPressed: () => handleStartButton(context, viewModel),
              gradientColors: AppGradients.greenGradient,
              textStyle: GoogleFonts.montserrat(
                fontSize: 24,
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

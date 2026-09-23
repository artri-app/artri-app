import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LevelExerciseSelector extends StatelessWidget {
  const LevelExerciseSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenHelper.getScreenWidth(context);

    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Escolha um nível de dificuldade para iniciar os exercícios:',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              ExerciseButton(
                onClick: () => viewModel.handleDifficultySelection(
                  ExerciseDifficulty.easy,
                  context,
                ),
                side: ExerciseButtonSide.left,
                buttonText: 'Iniciante',
                color: AppColors.neutral,
                width: screenWidth * 0.65,
              ),
              ExerciseButton(
                onClick: () => viewModel.handleDifficultySelection(
                  ExerciseDifficulty.medium,
                  context,
                ),
                side: ExerciseButtonSide.left,
                buttonText: 'Intermediário',
                color: AppColors.neutral,
                width: screenWidth * 0.65,
              ),
              ExerciseButton(
                onClick: () => viewModel.handleDifficultySelection(
                  ExerciseDifficulty.hard,
                  context,
                ),
                buttonText: 'Avançado',
                color: AppColors.neutral,
                side: ExerciseButtonSide.left,
                width: screenWidth * 0.65,
              ),
              GreenActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => LevelSelectorDialog(),
                ),
                text: 'QUAL DEVO ESCOLHER?',
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

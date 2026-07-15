import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/custom_app_bar.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomExerciseDifficultySelector extends StatelessWidget {
  const CustomExerciseDifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenHelper.getScreenWidth(context);

    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(value: 'EXERCICIOS PERSONALIZADOS'),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 40,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Escolha um nível de dificuldade para iniciar os exercícios:',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                ),
                ExerciseButton(
                  onClick: () => viewModel.setCustomExercisesDificulty(
                    ExerciseDifficulty.easy,
                    context,
                  ),
                  side: ExerciseButtonSide.left,
                  buttonText: 'Iniciante',
                  color: AppColors.neutral,
                  width: screenWidth * 0.65,
                ),
                ExerciseButton(
                  onClick: () => viewModel.setCustomExercisesDificulty(
                    ExerciseDifficulty.medium,
                    context,
                  ),
                  side: ExerciseButtonSide.left,
                  buttonText: 'Intermediário',
                  color: AppColors.neutral,
                  width: screenWidth * 0.65,
                ),
                ExerciseButton(
                  onClick: () {
                    viewModel.setCustomExercisesDificulty(
                      ExerciseDifficulty.hard,
                      context,
                    );
                  },
                  buttonText: 'Avançado',
                  color: AppColors.neutral,
                  side: ExerciseButtonSide.left,
                  width: screenWidth * 0.65,
                ),
                CustomSolidButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => LevelSelectorDialog(),
                  ),
                  text: 'Qual devo escolher?',
                  color: AppColors.lightBrown,
                  width: screenWidth * 0.80,
                  textStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

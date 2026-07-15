import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/enums/exercise_difficulty.dart';
import 'package:artriapp/view_models/physical_exercises.view_model.dart';
import 'package:artriapp/views/widgets/custom_app_bar.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:artriapp/views/widgets/select_exercises_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalizeExerciseRoutine extends StatelessWidget {
  const PersonalizeExerciseRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(value: 'EXERCICIOS PERSONALIZADOS'),
      body: Consumer<PhysicalExercisesViewModel>(
        builder: (context, viewModel, _) => Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 214,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Gap(24),
                            Text((viewModel.currentDifficulty ?? ExerciseDifficulty.easy).toTitleName(),
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                color: AppColors.mediumGreen,
                              ),
                            ),
                            Gap(24),
                            Text(
                              'Vamos começar a montar sua rotina de exercícios personalizada de hoje! Clique para escolher os exercícios indicados abaixo:',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            ),
                            Gap(16),
                            SelectExercisesCard(text: 'Escolha x exercicios de mobilidade'),
                            SelectExercisesCard(text: 'Escolha x exercicios de aquecimento'),
                            SelectExercisesCard(text: 'Escolha x exercicios para as pernas'),
                            SelectExercisesCard(text: 'Escolha x exercicios para os bracos'),
                            SelectExercisesCard(text: 'Escolha x exercicios para o tronco'),
                            SelectExercisesCard(text: 'Escolha x exercicios de alongamento'),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        CustomSolidButton(
                          text: 'Comecar',
                          color: AppColors.mediumGreen,
                          onPressed: () async {
                            await viewModel.getExerciseList(viewModel.customExerciseRoutineTrainingTypeList[viewModel.currentCustomTrainingPage]).then(
                              (value) => viewModel.goToSelectExercises(0, context),
                            );
                          },
                        ),
                        Gap(32),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

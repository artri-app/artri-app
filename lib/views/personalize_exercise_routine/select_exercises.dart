import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/utils/enums/exercise_difficulty.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/physical_exercises.view_model.dart';
import 'package:artriapp/views/widgets/custom_app_bar.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:artriapp/views/widgets/exercise_selection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectExercises extends StatelessWidget {
  const SelectExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      // ignore: deprecated_member_use
      builder: (context, viewModel, _) => WillPopScope(
        onWillPop: () async{
          if (viewModel.currentCustomTrainingPage > 0) {
            viewModel.returnSelectExercisesPage();
          } 
          GoRouter.of(context).pop();
          if ((context).canPop()) {
            return true;
          } else {
            return false;
          }
        },
        child: Scaffold(
        appBar: CustomAppBar(
          value: 'EXERCICIOS PERSONALIZADOS',
          onReturn: () {
            if (viewModel.currentCustomTrainingPage > 0) {
              viewModel.returnSelectExercisesPage();
            } 
            GoRouter.of(context).pop();
          },
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
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
                                'Selecione 2 exercícios de mobilidade para ${viewModel.selectionList[viewModel.currentCustomTrainingPage].type.toString().toLowerCase()} das opções abaixo:',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontSize: 24,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                              Gap(16),
                              SizedBox(
                                height: viewModel.selectionList[viewModel.currentCustomTrainingPage].exerciseList.length * 92,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: viewModel.selectionList[viewModel.currentCustomTrainingPage].exerciseList.length,
                                  itemBuilder: (context, index) {
                                    Exercise currentExercise = viewModel.selectionList[viewModel.currentCustomTrainingPage].exerciseList[index];
                                    return ExerciseSelection(
                                      exercise: currentExercise,
                                      selected: viewModel.customExerciseList[viewModel.currentCustomTrainingPage].exerciseList.contains(currentExercise),
                                      onClick: () {
                                          viewModel.toggleExerciseInList(currentExercise);
                                      },
                                    );
                                  }
                                ),
                              ),
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
                              viewModel.goToSelectExercises(viewModel.currentCustomTrainingPage + 1, context);
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
      ),
    );
  }
}

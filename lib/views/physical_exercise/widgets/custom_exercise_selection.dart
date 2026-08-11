import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CustomExerciseSelection extends StatefulWidget {
  const CustomExerciseSelection({super.key});

  @override
  State<CustomExerciseSelection> createState() =>
      _CustomExerciseSelectionState();
}

class _CustomExerciseSelectionState
    extends State<CustomExerciseSelection> {
  bool orientationsOpen = false;

  void handleNextButton(
      BuildContext context,
      PhysicalExercisesViewModel viewModel,
      int trainingId,
  ) {
    if (trainingId == viewModel.categoriesCount - 1) {
      if (orientationsOpen) {
        setState(() => orientationsOpen = false);
        viewModel.handleUpdateIndexCustomTraining(context, trainingId);
        return;
      }

      setState(() => orientationsOpen = true);
      showDialog(
        builder: (context) => OrientationsDialog(),
        context: context,
      );
    } else {
      viewModel.handleUpdateIndexCustomTraining(context, trainingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        final trainingId = viewModel.getTrainingId(context);
        final exercises = viewModel.getExercisesForIndex(trainingId);
        final selectionNumber = viewModel.getSelectionNumber(viewModel.currentDifficulty)[trainingId];
        final currentCategory = CustomType.values.elementAt(trainingId);
        final prepositionCategory =
          currentCategory == CustomType.legs ? 'para as' :
          currentCategory == CustomType.arms ? 'para os' :
          currentCategory == CustomType.core ? 'para o' :
          'de';
        final selectionNumberRequired = viewModel.getTotalExercisesNeeded(viewModel.currentDifficulty)[trainingId] ?? 0;
        final firstPartMobility = viewModel.getCustomMobility(viewModel.currentDifficulty)[0];
        final secondPartMobility = viewModel.getCustomMobility(viewModel.currentDifficulty)[1];
        final thirdPartMobility = viewModel.getCustomMobility(viewModel.currentDifficulty)[2];

        if (trainingId == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      children: [
                        // SEÇÃO 1
                        Text(
                          'Selecione $firstPartMobility ${firstPartMobility == 1 ? 'exercício' : 'exercícios'} de mobilidade para ${viewModel.mobilityParts[0]}:',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: viewModel.totalMobility[0],
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: ExerciseTile(
                                    exerciseName: exercise.name,
                                    customIcon: CupertinoIcons.play_arrow_solid,
                                  ),
                                ),
                                Checkbox(
                                  value: viewModel.getMobilityIds(0).contains(exercise.id),
                                  onChanged: (value) {
                                    viewModel.toggleCustomMobilityExerciseSelection(0, exercise.id);
                                    viewModel.toggleCustomExerciseSelection(exercise.id);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        // SEÇÃO 2
                        Text(
                          'Selecione $secondPartMobility ${secondPartMobility == 1 ? 'exercício' : 'exercícios'} de mobilidade para ${viewModel.mobilityParts[1]}:',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: viewModel.totalMobility[1],
                          itemBuilder: (context, index) {
                            final exercise = exercises[index + viewModel.totalMobility[0]];
                            return Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: ExerciseTile(
                                    exerciseName: exercise.name,
                                    customIcon: CupertinoIcons.play_arrow_solid,
                                  ),
                                ),
                                Checkbox(
                                  value: viewModel.getMobilityIds(1).contains(exercise.id),
                                  onChanged: (value) {
                                    viewModel.toggleCustomMobilityExerciseSelection(1, exercise.id);
                                    viewModel.toggleCustomExerciseSelection(exercise.id);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        // SEÇÃO 3
                        Text(
                          'Selecione $thirdPartMobility ${thirdPartMobility == 1 ? 'exercício' : 'exercícios'} de mobilidade para ${viewModel.mobilityParts[2]}:',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: viewModel.totalMobility[2],
                          itemBuilder: (context, index) {
                            final exercise = exercises[index + viewModel.totalMobility[0] + viewModel.totalMobility[1]];
                            return Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: ExerciseTile(
                                    exerciseName: exercise.name,
                                    customIcon: CupertinoIcons.play_arrow_solid,
                                  ),
                                ),
                                Checkbox(
                                  value: viewModel.getMobilityIds(2).contains(exercise.id),
                                  onChanged: (value) {
                                    viewModel.toggleCustomMobilityExerciseSelection(2, exercise.id);
                                    viewModel.toggleCustomExerciseSelection(exercise.id);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomSolidButton(
                text: 'Próximo'.toUpperCase(),
                onPressed: (viewModel.getCustomMobility(viewModel.currentDifficulty)[0] == viewModel.getMobilityIds(0).length && viewModel.getCustomMobility(viewModel.currentDifficulty)[1] == viewModel.getMobilityIds(1).length && viewModel.getCustomMobility(viewModel.currentDifficulty)[2] == viewModel.getMobilityIds(2).length)
                    ? () => handleNextButton(context, viewModel, trainingId)
                    : null,
                gradientColors: AppGradients.greenGradient,
                textStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else if (trainingId < viewModel.categoriesCount - 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                'Selecione $selectionNumber ${selectionNumber == 1 ? 'exercício' : 'exercícios'} $prepositionCategory ${currentCategory.toString().toLowerCase()}:',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Scrollbar(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: ExerciseTile(
                              exerciseName: exercise.name,
                              customIcon: CupertinoIcons.play_arrow_solid,
                            ),
                          ),
                          Checkbox(
                            value: viewModel.customExercisesIds.contains(exercise.id),
                            onChanged: (value) {
                              viewModel.toggleCustomExerciseSelection(exercise.id);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CustomSolidButton(
                text: 'Próximo'.toUpperCase(),
                onPressed: selectionNumberRequired == viewModel.customExercisesIds.length
                    ? () => handleNextButton(context, viewModel, trainingId)
                    : null,
                gradientColors: AppGradients.greenGradient,
                textStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                'Selecione $selectionNumber ${selectionNumber == 1 ? 'exercício' : 'exercícios'} $prepositionCategory ${currentCategory.toString().toLowerCase()}:',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Scrollbar(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: ExerciseTile(
                              exerciseName: exercise.name,
                              customIcon: CupertinoIcons.play_arrow_solid,
                            ),
                          ),
                          Checkbox(
                            value: viewModel.customExercisesIds.contains(exercise.id),
                            onChanged: (value) {
                              viewModel.toggleCustomExerciseSelection(exercise.id);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CustomSolidButton(
                text: 'Começar'.toUpperCase(),
                onPressed: selectionNumberRequired == viewModel.customExercisesIds.length
                    ? () => handleNextButton(context, viewModel, trainingId)
                    : null,
                gradientColors: AppGradients.greenGradient,
                textStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

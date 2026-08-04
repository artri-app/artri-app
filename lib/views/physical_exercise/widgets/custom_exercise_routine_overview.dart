import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CustomExerciseRoutineOverview extends StatefulWidget {
  const CustomExerciseRoutineOverview({super.key});

  @override
  State<CustomExerciseRoutineOverview> createState() =>
      _CustomExerciseRoutineOverviewState();
}

class _CustomExerciseRoutineOverviewState
    extends State<CustomExerciseRoutineOverview> {
  void handleStartButton(
      BuildContext context,
      PhysicalExercisesViewModel viewModel,
  ) {
    viewModel.handleStartCustomExercisesSelection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              'Vamos começar a montar sua rotina de exercícios personalizada de hoje! Clique para escolher os exercícios indicados abaixo:',
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: viewModel.categoriesCount,
                  itemBuilder: (context, index) => ExerciseTile(
                    exerciseName: 'Escolha ${viewModel.selectionNumbers[viewModel.currentDifficulty]![index]} ${viewModel.selectionNumbers[viewModel.currentDifficulty]![index] == 1 ? 'exercício' : 'exercícios'} ${CustomType.values.elementAt(index) == CustomType.legs ? 'para as' : CustomType.values.elementAt(index) == CustomType.arms ? 'para os' : CustomType.values.elementAt(index) == CustomType.core ? 'para o' : 'de'} ${CustomType.values.elementAt(index).toString().toLowerCase()}',
                    customIcon: CupertinoIcons.create,
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

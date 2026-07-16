import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomExerciseRoutineOverview extends StatefulWidget {
  const CustomExerciseRoutineOverview({super.key});

  @override
  State<CustomExerciseRoutineOverview> createState() =>
      _CustomExerciseRoutineOverviewState();
}

class _CustomExerciseRoutineOverviewState
    extends State<CustomExerciseRoutineOverview> {
  bool orientationsOpen = false;

  void handleStartButton(
    BuildContext context,
    PhysicalExercisesViewModel viewModel,
  ) {
    if (orientationsOpen) {
      setState(() => orientationsOpen = false);
      viewModel.startCustomRoutine(context);
      return;
    }

    setState(() => orientationsOpen = true);
    showDialog(
      builder: (context) => OrientationsDialog(),
      context: context,
    );
  }

  void handleEditCategory(BuildContext context, TrainingType type) {
    final currentPath = RouterHelper.getUriFromContext(context);
    context.push('$currentPath/category/${type.name}');
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
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemCount: CustomExerciseCategoryHelper.categories.length,
                  itemBuilder: (context, index) {
                    final category =
                        CustomExerciseCategoryHelper.categories[index];

                    return CustomExerciseCategoryTile(
                      prefixText:
                          CustomExerciseCategoryHelper.getPrefixText(category),
                      categoryName:
                          CustomExerciseCategoryHelper.getCategoryName(
                        category,
                      ),
                      onEdit: () => handleEditCategory(context, category),
                    );
                  },
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

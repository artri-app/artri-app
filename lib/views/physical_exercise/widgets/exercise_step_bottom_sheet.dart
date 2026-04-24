import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/physical_exercises.view_model.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExerciseStepBottomSheet extends StatelessWidget {
  final bool hasPrevious;
  final bool hasNext;
  final bool isCompleted;

  const ExerciseStepBottomSheet({
    super.key,
    this.hasPrevious = true,
    this.hasNext = true,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return SafeArea(
          bottom: true,
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            color: AppColors.lightBrown,
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 52,
                  disabledColor: Colors.transparent,
                  color: AppColors.darkGreen,
                  onPressed: hasPrevious
                      ? () => viewModel.handlePreviousExercise(context)
                      : null,
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                  ),
                ),
                Expanded(
                  child: CustomOutlinedButton(
                    disabledColor: AppColors.darkGreen.withAlpha(127),
                    color: AppColors.darkGreen,
                    text: 'Feito',
                    onPressed: !isCompleted
                        ? () => viewModel.handleCompleteExercise(context)
                        : null,
                    borderWidth: 4,
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.darkGreen,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 52,
                  disabledColor: Colors.transparent,
                  color: AppColors.darkGreen,
                  onPressed: hasNext && isCompleted
                      ? () => viewModel.handleNextExercise(context)
                      : null,
                  icon: const Icon(
                    Icons.arrow_circle_right_outlined,
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

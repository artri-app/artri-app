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

  double _getButtonFontSize(double width) {
    if (width < 360) return 18;
    if (width < 420) return 20;
    if (width < 520) return 24;
    return 30;
  }

  double _getIconSize(double width) {
    if (width < 360) return 38;
    if (width < 420) return 44;
    return 52;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final buttonFontSize = _getButtonFontSize(width);
            final iconSize = _getIconSize(width);
            final horizontalPadding = width < 360 ? 10.0 : 16.0;

            return SafeArea(
              bottom: true,
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8,
                ),
                color: AppColors.lightBrown,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      constraints: BoxConstraints(
                        minWidth: iconSize + 8,
                        minHeight: iconSize + 8,
                      ),
                      iconSize: iconSize,
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
                        borderWidth: width < 360 ? 2.5 : 4,
                        borderRadius: 16,
                        textStyle: GoogleFonts.montserrat(
                          color: AppColors.darkGreen,
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      constraints: BoxConstraints(
                        minWidth: iconSize + 8,
                        minHeight: iconSize + 8,
                      ),
                      iconSize: iconSize,
                      disabledColor: Colors.transparent,
                      color: AppColors.darkGreen,
                      onPressed: () => viewModel.handleNextExercise(context),
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
      },
    );
  }
}

import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhysicalExerciseView extends StatelessWidget {
  final Widget child;
  final String title;
  final String? subtitle;
  const PhysicalExerciseView({
    super.key,
    required this.child,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, _) {
        var exerciseId =
            RouterHelper.getPathParameterFromContext(context, 'exerciseId');
        var currentExercise = viewModel.currentExercise;
        var isExercisePage = exerciseId != null && currentExercise != null;

        return ClearScaffoldView(
          appBarTitle: SessionTitle(
            title: title,
            subtitle: subtitle,
            size: 36,
          ),
          child: Column(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: child,
              ),
            ],
          ),
          bottomSheet: isExercisePage
              ? ExerciseStepBottomSheet(
                  hasNext: !currentExercise.isLast,
                  hasPrevious: !currentExercise.isFirst,
                  isCompleted: currentExercise.isCompleted,
                )
              : null,
        );
      },
    );
  }
}

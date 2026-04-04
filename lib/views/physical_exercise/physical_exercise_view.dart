import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    var exerciseId = GoRouter.of(context).state.pathParameters['id'];
    var isExercisePage = exerciseId != null && exerciseId != '-1';

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
      bottomSheet: isExercisePage ? ExerciseStepBottomSheet() : null,
    );
  }
}

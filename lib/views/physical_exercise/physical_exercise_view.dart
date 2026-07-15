import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/app_gradients.dart';
import 'package:artriapp/utils/enums/confirmation_action.dart';
import 'package:artriapp/utils/enums/exercise_difficulty.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/custom_app_bar.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
          appBar: CustomAppBar(
            onReturn: () async {
              if (viewModel.exercises.isNotEmpty) {
                bool shouldQuit = await showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(48)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.black, size: 96),
                              Text(
                              'ATENÇÃO!',
                              style: GoogleFonts.montserrat(
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            Gap(8),
                            Text(
                              'Se sair agora, perderá o progresso que fez ate aqui.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 26,
                              ),
                            ),
                            ],
                          ),
                            Column(
                              children: [
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomSolidButton(
                                    width: (MediaQuery.of(context).size.width / 2 ) - 24,
                                    fontSize: 20,
                                    text: 'Sair',
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    gradientColors: AppGradients.redGradient,
                                  ),
                                  CustomSolidButton(
                                    width: (MediaQuery.of(context).size.width / 2 ) - 24,
                                    fontSize: 20,
                                    horizontalPadding: 4,
                                    text: 'Continuar',
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    gradientColors: AppGradients.greenGradient,
                                  ),
                                ],
                                ),
                                  Gap(40),
                              ],
                            ),
                        ],),
                      ),
                    ),
                  ),
                );
                if (shouldQuit) {
                  GoRouter.of(context).go('/diary');
                }
              } else {
                context.pop();
              }
              
            },
            value: title),
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
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

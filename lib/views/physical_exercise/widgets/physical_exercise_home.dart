import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhysicalExerciseHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PhysicalExercisesViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          child: Column(
            spacing: 32,
            children: [
              Text(
                'Aqui você terá acesso a exercícios específicos e pré-determinados para suas mãos e pés. Clique para escolher o nível de dificuldade:',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              ExerciseButton(
                onClick: () => viewModel.handleTrainingTypeSelection(
                  TrainingType.hands,
                  context,
                ),
                gradientColors: AppGradients.greenToNeutral,
                buttonText: 'Mãos',
              ),
              ExerciseButton(
                onClick: () => viewModel.handleTrainingTypeSelection(
                  TrainingType.feetBoost,
                  context,
                ),
                gradientColors: AppGradients.greenToNeutral,
                buttonText: 'Pés',
              ),
              Text(
                'Aqui você terá acesso a exercícios personalizados para diferentes partes do corpo. Clique para escolher o nível de dificuldade e personalizar seus exercícios:',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              ExerciseButton(
                onClick: () =>
                    context.go(PhysicalExerciseRoutes.customExercises),
                gradientColors: AppGradients.greenToNeutral,
                buttonText: 'Personalizados',
                width: ScreenHelper.getScreenWidth(context) * 0.65,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/physical_exercises.view_model.dart';
import 'package:artriapp/views/physical_exercise/widgets/point_text.dart';
import 'package:artriapp/views/widgets/custom_app_bar.dart';
import 'package:artriapp/views/widgets/custom_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomExercisesConfirmationPage extends StatelessWidget {
  const CustomExercisesConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(value: 'EXERCICIOS PERSONALIZADOS'),
      body: Consumer<PhysicalExercisesViewModel>(
        builder: (context, viewModel, _) => Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Gap(24),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(32)),
                              color: AppColors.neutral,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.warning_amber_rounded, color: Colors.black, size: 120),
                                    Text(
                                      'ATENÇÃO!',
                                      style: GoogleFonts.montserrat(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                      ),
                                    ),
                                    Text(
                                      'Antes de iniciar os exercícios, para sua segurança:',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                      ),),
                                      Gap(8),
                                      PointText(text: 'Escolha um local seguro, sem objetos que possam causar quedas.'),
                                      Gap(8),
                                      PointText(text: 'Use roupas confortáveis e calçados firmes, se necessário.'),
                                      Gap(8),
                                      PointText(
                                        text: 'Faça os movimentos devagar, respeitando seus limites.',
                                        strongText: ' Caso não consiga realizar algum exercício, passe para o próximo.',
                                      ),
                                      Gap(8),
                                      PointText(text: 'Se sentir dor forte, tontura ou falta de ar, pare e procure orientação profissional.'),
                                      Gap(8),
                                      PointText(text: 'Mantenha água por perto e lembre-se de respirar com calma durante os exercícios.'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomSolidButton(
                          text: 'Comecar',
                          color: AppColors.mediumGreen,
                          onPressed: () {
                            viewModel.queueCustomExercises(context);
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
      );
  }
}
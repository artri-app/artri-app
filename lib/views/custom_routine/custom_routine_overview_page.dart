import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CustomRoutineOverviewPage extends StatefulWidget {
  final String level;
  const CustomRoutineOverviewPage({super.key, required this.level});

  @override
  State<CustomRoutineOverviewPage> createState() =>
      _CustomRoutineOverviewPageState();
}

class _CustomRoutineOverviewPageState extends State<CustomRoutineOverviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<CustomRoutineViewModel>();
      final template = vm.currentTemplate;
      if (template == null || template.level.toLowerCase() != widget.level.toLowerCase()) {
        vm.initRoutine(widget.level);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final customViewModel = context.watch<CustomRoutineViewModel>();
    final physicalExercisesVM = Provider.of<PhysicalExercisesViewModel>(context, listen: false);

    if (customViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final canStart = customViewModel.canStartRoutine();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Vamos começar a montar sua rotina de exercícios personalizada de hoje! Clique para escolher os exercícios indicados abaixo:',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          for (final category in customViewModel.currentTemplate?.categories ?? []) ...[
            GestureDetector(
              onTap: () {
                context.push('/custom_routine/select', extra: {
                  'key': category.key,
                  'title': category.title,
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.darkGreen, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.darkGreen,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            category.key == 'pernas' ||
                                    category.key == 'bracos' ||
                                    category.key == 'tronco'
                                ? 'Escolha ${category.requiredCount} exercícios para'
                                : 'Escolha ${category.requiredCount} exercícios de',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          Text(
                            category.title.toLowerCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (customViewModel.isCategoryComplete(category.key))
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 32,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
            child: CustomSolidButton(
              text: 'COMEÇAR',
              gradientColors: canStart ? AppGradients.greenGradient : [Colors.grey.shade400, Colors.grey.shade400],
              onPressed: canStart
                  ? () {
                      final exercises = customViewModel.generateFinalRoutine();
                      physicalExercisesVM.setCustomRoutine(exercises);
                      if (physicalExercisesVM.currentExercise != null) {
                        context.go('/custom_routine/overview/${widget.level}/${physicalExercisesVM.currentExercise!.id}');
                      }
                    }
                  : null,
              textStyle: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

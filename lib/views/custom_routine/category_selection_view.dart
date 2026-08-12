import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CategorySelectionView extends StatelessWidget {
  final String categoryTitle;
  final String categoryKey;

  const CategorySelectionView({
    super.key,
    required this.categoryTitle,
    required this.categoryKey,
  });

  @override
  Widget build(BuildContext context) {
    final customViewModel = context.watch<CustomRoutineViewModel>();
    final template = customViewModel.currentTemplate;
    if (template == null) return const SizedBox.shrink();
    final category = template.categories.firstWhere((c) => c.key == categoryKey);
    final exercises = customViewModel.exercisesForCategory(categoryKey);

    final double width = MediaQuery.sizeOf(context).width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              category.prompt,
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
          for (final exercise in exercises) ...[
            GestureDetector(
              onTap: () {
                customViewModel.toggleExercise(exercise, categoryKey);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: width * 0.15,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: AppColors.lightBrown,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: width * 0.1,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        exercise.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Checkbox(
                      value: customViewModel.isExerciseSelected(categoryKey, exercise.id),
                      onChanged: (bool? value) {
                        customViewModel.toggleExercise(exercise, categoryKey);
                      },
                      activeColor: AppColors.mediumGreen,
                      checkColor: Colors.white,
                      side: const BorderSide(color: AppColors.mediumGreen, width: 2),
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
              text: 'PRÓXIMO',
              gradientColors: AppGradients.greenGradient,
              onPressed: () {
                context.pop();
              },
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

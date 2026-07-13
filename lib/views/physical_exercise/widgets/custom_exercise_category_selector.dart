import 'package:artriapp/models/index.dart';
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

class CustomExerciseCategorySelector extends StatefulWidget {
  final TrainingType category;

  const CustomExerciseCategorySelector({super.key, required this.category});

  @override
  State<CustomExerciseCategorySelector> createState() =>
      _CustomExerciseCategorySelectorState();
}

class _CustomExerciseCategorySelectorState
    extends State<CustomExerciseCategorySelector> {
  Future<List<Exercise>>? _exercisesFuture;
  final Set<int> _selectedExerciseIds = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_exercisesFuture != null) return;

    final viewModel = context.read<PhysicalExercisesViewModel>();
    final difficulty = ExerciseDifficulty.fromString(
      RouterHelper.getPathParameterFromContext(context, 'difficulty')!,
    );

    _selectedExerciseIds.addAll(
      viewModel
          .getCustomCategorySelection(widget.category)
          .map((exercise) => exercise.id),
    );

    _exercisesFuture = viewModel.getCustomCategoryExercises(
      widget.category,
      difficulty,
    );
  }

  void handleNext(List<Exercise> exercises) {
    final selected = exercises
        .where((exercise) => _selectedExerciseIds.contains(exercise.id))
        .toList();

    context.read<PhysicalExercisesViewModel>().setCustomCategorySelection(
          widget.category,
          selected,
        );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercise>>(
      future: _exercisesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final exercises = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              '${CustomExerciseCategoryHelper.getSelectionInstructionPrefix(widget.category)} '
              '${CustomExerciseCategoryHelper.getCategoryName(widget.category)} das opções abaixo:',
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
                      const SizedBox(height: 16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];

                    return CustomExerciseSelectableTile(
                      exerciseName: exercise.name,
                      isSelected: _selectedExerciseIds.contains(exercise.id),
                      onChanged: (isSelected) => setState(() {
                        if (isSelected) {
                          _selectedExerciseIds.add(exercise.id);
                        } else {
                          _selectedExerciseIds.remove(exercise.id);
                        }
                      }),
                    );
                  },
                ),
              ),
            ),
            CustomSolidButton(
              text: 'Próximo'.toUpperCase(),
              onPressed: () => handleNext(exercises),
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

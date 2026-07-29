import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CustomRoutineAdvancedPage extends StatefulWidget {
  const CustomRoutineAdvancedPage({super.key});

  @override
  State<CustomRoutineAdvancedPage> createState() => _CustomRoutineAdvancedPageState();
}

class _CustomRoutineAdvancedPageState extends State<CustomRoutineAdvancedPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CustomRoutineAdvancedViewModel>();
    final physicalExercisesVM = Provider.of<PhysicalExercisesViewModel>(context, listen: false);
    final double width = MediaQuery.sizeOf(context).width;

    final filteredExercises = viewModel.filteredExercises;
    final canStart = viewModel.selectedCount > 0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Personalizados Avançado',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Selecione os exercícios que deseja incluir em seu treino hoje. Pesquise e filtre como desejar:',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Search Input Field
            TextField(
              controller: _searchController,
              onChanged: (val) => viewModel.updateSearchQuery(val),
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Pesquise por nome...',
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.darkGreen,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.darkGreen),
                        onPressed: () {
                          _searchController.clear();
                          viewModel.updateSearchQuery('');
                        },
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.darkGreen, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.darkGreen, width: 2.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Horizontal Scroll Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => viewModel.selectCategory(null),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: viewModel.selectedCategory == null
                            ? AppColors.darkGreen
                            : Colors.transparent,
                        border: Border.all(color: AppColors.darkGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Todos',
                        style: GoogleFonts.montserrat(
                          color: viewModel.selectedCategory == null
                              ? Colors.white
                              : AppColors.darkGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ...viewModel.categories.map((catKey) {
                    final label = viewModel.categoryLabels[catKey] ?? catKey;
                    final isSelected = viewModel.selectedCategory == catKey;
                    return GestureDetector(
                      onTap: () => viewModel.selectCategory(catKey),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.darkGreen : Colors.transparent,
                          border: Border.all(color: AppColors.darkGreen, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.montserrat(
                            color: isSelected ? Colors.white : AppColors.darkGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Exercises List
            if (filteredExercises.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'Nenhum exercício encontrado.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    textStyle: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            else
              ...filteredExercises.map((exercise) {
                final isSelected = viewModel.isExerciseSelected(exercise.id);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      viewModel.toggleExerciseSelection(exercise.id);
                    },
                    behavior: HitTestBehavior.opaque,
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
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            viewModel.toggleExerciseSelection(exercise.id);
                          },
                          activeColor: AppColors.mediumGreen,
                          checkColor: Colors.white,
                          side: const BorderSide(color: AppColors.mediumGreen, width: 2),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 24),
            // INICIAR TREINO Action Button
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: CustomSolidButton(
                text: 'INICIAR TREINO (${viewModel.selectedCount})',
                gradientColors: canStart ? AppGradients.greenGradient : [Colors.grey.shade400, Colors.grey.shade400],
                onPressed: canStart
                    ? () {
                        final exercises = viewModel.generateRoutine();
                        physicalExercisesVM.setCustomRoutine(exercises);
                        if (physicalExercisesVM.currentExercise != null) {
                          context.go('/custom_routine/overview/${physicalExercisesVM.currentExercise!.id}');
                        }
                      }
                    : null,
                textStyle: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

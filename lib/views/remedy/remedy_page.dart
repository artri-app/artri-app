import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RemedyPage extends StatefulWidget {
  const RemedyPage({super.key});

  @override
  State<RemedyPage> createState() => _RemedyPageState();
}

class _RemedyPageState extends State<RemedyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RemedyViewModel>().fetchRemedies();
      context.read<RemedyViewModel>().fetchTodayIntakes();
    });
  }

  Future<void> _confirmDelete(
    BuildContext context,
    RemedyViewModel model,
    Remedy remedy,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover medicamento'),
        content: Text('Deseja remover "${remedy.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      model.deleteRemedy(remedy.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RemedyViewModel>(
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.darkGreen,
                          ),
                          onPressed: () => context.canPop()
                              ? context.pop()
                              : context.go(UserDiaryRoutes.diary),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'MEDICAMENTOS',
                          style: GoogleFonts.montserrat(
                            fontSize: 26,
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: AppColors.darkGreen,
                        size: 30,
                      ),
                      onPressed: () {
                        context.push(LoggedRoutes.addRemedy);
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('Checklist diário de tratamento'),
              ),
              const SizedBox(height: 20),
              if (model.isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (model.remedies.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('Nenhum medicamento cadastrado.'),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: model.remedies.length,
                    itemBuilder: (context, index) {
                      final remedy = model.remedies[index];
                      final isTaken = model.isTaken(remedy.id);
                      final isScheduledToday = model.isScheduledToday(remedy);

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isTaken
                                  ? AppColors.darkGreen
                                  : AppColors.darkGreenSurface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.medication_liquid_sharp,
                              color:
                                  isTaken ? Colors.white : AppColors.darkGreen,
                            ),
                          ),
                          title: Text(
                            remedy.name,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              decoration:
                                  isTaken ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          subtitle: Text(
                            '${remedy.quantity.isNotEmpty ? remedy.quantity : 'Sem dose informada'} • ${remedy.hour} • '
                            '${remedy.daysOfWeek.map((day) => day.shortLabel).join(', ')} • '
                            '${remedy.reminderEnabled ? 'Lembrete ativo' : 'Sem lembrete'}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.darkGreen,
                                ),
                                onPressed: () => context.push(
                                  LoggedRoutes.addRemedy,
                                  extra: remedy,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade400,
                                ),
                                onPressed: () =>
                                    _confirmDelete(context, model, remedy),
                              ),
                              Checkbox(
                                activeColor: AppColors.darkGreen,
                                value: isTaken,
                                onChanged: isScheduledToday
                                    ? (_) => model.toggleTaken(remedy.id)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

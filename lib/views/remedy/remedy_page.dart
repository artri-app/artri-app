import 'package:artriapp/services/remedy_service.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/models/api_responses/remedy.dart';
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
    });
  }

  String _formatDays(List<DaysOfWeek> days) {
    if (days.isEmpty) return 'Todos os dias';
    const labels = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return days.map((d) => labels[d.index]).join(', ');
  }

  void _showAddRemedySheet(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final quantityController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();
    List<DaysOfWeek> selectedDays = DaysOfWeek.values.toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Novo Medicamento',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do remédio',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: ctx,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setSheetState(() => selectedTime = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Horário',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(selectedTime.format(ctx)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Dias da semana:',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: DaysOfWeek.values.map((day) {
                      const labels = [
                        'Seg',
                        'Ter',
                        'Qua',
                        'Qui',
                        'Sex',
                        'Sáb',
                        'Dom',
                      ];
                      final selected = selectedDays.contains(day);
                      return FilterChip(
                        label: Text(labels[day.index]),
                        selected: selected,
                        selectedColor:
                            AppColors.darkGreen.withValues(alpha: 0.3),
                        onSelected: (val) {
                          setSheetState(() {
                            if (val) {
                              selectedDays.add(day);
                            } else {
                              selectedDays.remove(day);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  if (context.read<RemedyViewModel>().errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        context.read<RemedyViewModel>().errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isEmpty) return;
                      final qty =
                          int.tryParse(quantityController.text.trim()) ?? 0;
                      final hour =
                          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

                      await context.read<RemedyViewModel>().saveRemedy(
                            name: name,
                            description: descController.text.trim(),
                            quantity: qty,
                            hour: hour,
                            daysOfWeek: selectedDays,
                          );
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: Text(
                      'Salvar',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _confirmDeleteRemedy(
    BuildContext context,
    Remedy remedy,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir medicamento'),
          content: Text(
            'Deseja realmente excluir o medicamento "${remedy.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      try {
        // Exibe indicador de carregamento ou feedback visual se desejar
        final remedyService = RemedyService();
        await remedyService.deleteRemedy(remedy.id);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medicamento excluído com sucesso!')),
          );
          // Atualize a lista local ou chame o setState/provider aqui
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao excluir: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MEDICAMENTOS',
          style: GoogleFonts.montserrat(
            fontSize: 26,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () =>
                context.canPop() ? context.pop() : context.go('/diary'),
            style: ButtonStyle(
              side: WidgetStatePropertyAll(
                const BorderSide(color: AppColors.darkGreen, width: 2),
              ),
            ),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.darkGreen,
              size: 24,
            ),
          ),
        ),
      ),
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
                    Expanded(
                      child: Text(
                        'MEDICAMENTOS',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 26,
                          color: AppColors.darkGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: AppColors.darkGreen,
                        size: 30,
                      ),
                      onPressed: () => _showAddRemedySheet(context),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                            '${remedy.hour} - ${_formatDays(remedy.daysOfWeek)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                activeColor: AppColors.darkGreen,
                                value: isTaken,
                                onChanged: (_) => model.toggleTaken(remedy.id),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                tooltip: 'Excluir medicamento',
                                onPressed: () => _confirmDeleteRemedy(
                                  context,
                                  remedy,
                                ),
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

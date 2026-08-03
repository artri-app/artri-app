import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:flutter/material.dart';
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
                    Text(
                      'MEDICAMENTOS',
                      style: GoogleFonts.montserrat(
                        fontSize: 26,
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: AppColors.darkGreen,
                        size: 30,
                      ),
                      onPressed: () {
                        // Modal (BottomSheet) implementado ao invés de tela morta
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) {
                            return Padding(
                              // Evita que o teclado cubra o modal
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
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
                                  const TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Nome do remédio',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkGreen,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    onPressed: () {
                                      // TODO: Chamar o ViewModel para salvar no banco
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Salvar',
                                      style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            );
                          },
                        );
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
                          subtitle: const Text('Sem detalhes de dose/horário'),
                          trailing: Checkbox(
                            activeColor: AppColors.darkGreen,
                            value: isTaken,
                            onChanged: (_) => model.toggleTaken(remedy.id),
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

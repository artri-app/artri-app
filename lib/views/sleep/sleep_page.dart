import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// Importe o seu ViewModel (substitua pelo nome real caso seja diferente)
import 'package:artriapp/view_models/diary_view_model.dart'; 

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _FatgiuePageState();
}

class _FatgiuePageState extends State<SleepPage> {
  // Variável de estado para guardar o valor escolhido pelo utilizador
  int _nivelSono = 0; 
  bool _isLoading = false; // Controle de loading

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('O que é Fadiga e Sono?'),
                    content: const Text(
                        'A fadiga é a sensação de cansaço extremo e falta de energia. Aqui avaliamos como isso e a qualidade do seu sono afetam o seu dia.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Entendi'),
                      ),
                    ],
                  );
                },
              );
            },
            iconSize: 40,
            icon: const Icon(Icons.help_outline, color: AppColors.darkGreen),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    // ... (Mantenha todo o código visual do Avatar, Gap, Textos até à escala) ...
                    
                    CustomScaleSelectorWidget(
                      onChanged: (value) {
                        setState(() {
                          _nivelSono = value.toInt(); // Atualiza o estado
                        });
                      },
                    ),
                    const Gap(32),
                    
                    // Botões de Ação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Voltar',
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        // Botão Salvar Integrado
                        _isLoading 
                          ? const CircularProgressIndicator(color: AppColors.darkGreen)
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                setState(() => _isLoading = true);
                                
                                // Bate na API real usando o ViewModel
                                // NOTA: Verifique o nome exato do método no seu ViewModel
                                final sucesso = await context
                                    .read<DiaryViewModel>() // ou FatigueViewModel
                                    .enviarRelatorioSono(nivel: _nivelSono); 

                                setState(() => _isLoading = false);

                                if (sucesso && context.mounted) {
                                  // Mostra um feedback visual de sucesso
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Guardado com sucesso!')),
                                  );
                                  // Sai da tela e volta ao ecrã inicial
                                  Navigator.pop(context);
                                } else if (context.mounted) {
                                  // Mostra erro caso o servidor falhe
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Erro ao comunicar com o servidor.')),
                                  );
                                }
                              },
                              child: Text(
                                'Salvar',
                                style: GoogleFonts.montserrat(color: Colors.white),
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
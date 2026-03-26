//import 'package:artriapp/routes/relaxation.routes.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/views/relaxation/widget/relaxation_tile.dart';
import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BreathingTechniquesPage extends StatelessWidget {
  const BreathingTechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: 'TÉCNICAS DE RESPIRAÇÃO',
            size: 36,
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: AppColors.darkGreen,
                ),
              ),
              children: const [
                TextSpan(
                  text: 'As ',
                ),
                TextSpan(
                  text: 'técnicas de respiração',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' são exercícios simples que ajudam a controlar o ritmo da respiração. Podem ser usadas no dia a dia para aliviar o estresse, melhorar a concentração e reduzir a tensão muscular. Respirar de forma consciente também ajuda no relaxamento físico e mental, sendo útil em momentos de dor, ansiedade ou cansaço.',
                ),
              ],
            ),
          ),
          Text(
            'Escolha um vídeo abaixo e experimente!',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
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
                itemCount: 4,
                itemBuilder: (context, index) {
                  final audioName = 'Contagem de ${index + 1} segundos';
                  final titleName = 'Técnicas de respiração';

                  return RelaxationTile(
                    audioName: audioName,
                    onTap: () => context.push(
                      '/relaxation/audio/', extra: titleName,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

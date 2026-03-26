//import 'package:artriapp/routes/relaxation.routes.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/views/relaxation/widget/relaxation_tile.dart';
import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GuidedRelaxationPage extends StatelessWidget {
  const GuidedRelaxationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: 'RELAXAMENTO GUIADO',
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
                  text: 'O ',
                ),
                TextSpan(
                  text: 'relaxamento guiado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' por meio de áudios é uma técnica simples que ajuda a acalmar o corpo e a mente. Pode ajudar a reduzir o estresse, aliviar dores, melhorar o sono e aumentar a sensação de bem-estar.',
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
                  final audioName = 'Exercício de relaxamento ${index + 1}';

                  return RelaxationTile(
                    audioName: audioName,
                    onTap: () => context.push(
                      '/relaxation/audio/', extra: audioName,
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

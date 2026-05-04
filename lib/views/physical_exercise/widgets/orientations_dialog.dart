import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrientationsDialog extends StatelessWidget {
  const OrientationsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(
        16,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                spacing: 4,
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    size: 102,
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
                  Text(
                    'ATENÇÃO!',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Antes de iniciar os exercícios, para sua segurança:',
              style: GoogleFonts.montserrat(fontSize: 24),
            ),
            Text(
              '- Escolha um local seguro, sem objetos que possam causar quedas.',
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            Text(
              '- Use roupas confortáveis e calçados firmes, se necessário.',
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            Text(
              '- Faça os movimentos devagar, respeitando seus limites. Caso não consiga realizar algum exercício, passe para o próximo.',
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            Text(
              '- Se sentir dor forte, tontura ou falta de ar, pare e procure orientação profissional.',
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            Text(
              '- Mantenha água por perto e lembre-se de respirar com calma durante os exercícios.',
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

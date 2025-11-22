import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtriteReumatoideInfoPage extends StatelessWidget {
  const ArtriteReumatoideInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        title: const Text(
          'Artrite Reumatóide',
        ),
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () => context.pop(),
            style: ButtonStyle(
              side: WidgetStatePropertyAll(
                const BorderSide(color: Colors.white, width: 2),
              ),
            ),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O que é Artrite Reumatóide?',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'A artrite reumatoide (AR) é uma doença crônica que causa inflamação nas articulações e é autoimune, ou seja, o próprio sistema imunológico ataca o corpo.',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(20),
            Text(
              'A causa da Artrite Reumatoide',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'Descrição da causa da Artrite Reumatoide.',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(20),
            Text(
              'Sintomas',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'Descrição dos sintomas da Artrite Reumatoide.',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

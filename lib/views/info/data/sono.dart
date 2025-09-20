import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SonoInfoPage extends StatelessWidget {
  const SonoInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        title: const Text(
          'Sono',
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
              'Título',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'Descrição 1',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(20),
            Text(
              'Subtítulo 1',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'Descrição 2',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(20),
            Text(
              'Subtítulo 2',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(10),
            Text(
              'Descrição 3',
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

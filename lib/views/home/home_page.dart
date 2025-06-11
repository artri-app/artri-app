import 'package:flutter/material.dart';
import 'package:artriapp/views/widgets/navbar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artriapp/views/widgets/button_rounded.dart';
import 'package:artriapp/views/widgets/button_fade.dart';
import 'package:artriapp/views/widgets/question_card.dart';
import 'package:artriapp/views/config/config_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConfigPage()),
            ),
            icon: const Icon(
              Icons.settings,
              color: Color(0xff025940),
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(20),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff025940),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                const Gap(24),
                Text(
                  'Olá, {nome}!',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    color: const Color(0xff026873),
                  ),
                ),
                const Gap(10),
                Text(
                  'Como você está hoje?'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const Gap(32),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    RoundedButton(
                      color: Color(0xFF026873),
                      icon: Icons.abc,
                      label: 'Dor',
                      onPressed: () {},
                    ),
                    RoundedButton(
                      color: Color(0xFF026873),
                      icon: Icons.abc,
                      label: 'Fadiga',
                      onPressed: () {},
                    ),
                    RoundedButton(
                      color: Color(0xFF026873),
                      icon: Icons.abc,
                      label: 'Sono',
                      onPressed: () {},
                    ),
                    RoundedButton(
                      color: Color(0xFF026873),
                      icon: Icons.abc,
                      label: 'Inchaço',
                      onPressed: () {},
                    )
                  ],
                ),
                const Gap(32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeButton(
                      label: 'Medicamentos',
                      onPressed: () {
                        // Navigate to Mitos e Verdades page
                      },
                      width: 160,
                      height: 48,
                      elevation: 6,
                    ),
                    const Gap(16),
                    FadeButton(
                      label: 'Exercícios',
                      onPressed: () {
                        // Navigate to Exercícios page
                      },
                      width: 160,
                      height: 48,
                      elevation: 6,
                    ),
                  ],
                ),
                const Gap(32),
                QuestionCard(
                  question: 'Você está se sentindo bem?',
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(currentPage: 0, previousPage: null),
    );
  }
}

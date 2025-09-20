import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artriapp/views/widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.darkGreen,
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
                    onPressed: () => context.goNamed(Routes.painPage),
                  ),
                  RoundedButton(
                    color: Color(0xFF026873),
                    icon: Icons.abc,
                    label: 'Fadiga',
                    onPressed: () => context.goNamed(Routes.fatiguePage),
                  ),
                  RoundedButton(
                    color: Color(0xFF026873),
                    icon: Icons.abc,
                    label: 'Sono',
                    onPressed: () => context.goNamed(Routes.sleepPage),
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
            ],
          ),
        ),
      ),
    );
  }
}

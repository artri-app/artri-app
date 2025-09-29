import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class UserDiaryInitialSelection extends StatelessWidget {
  const UserDiaryInitialSelection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.sentiment_dissatisfied_rounded,
              label: 'Dor',
              onPressed: () => context.push(
                AppRoutes.painSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.battery_alert_outlined,
              label: 'Fadiga',
              onPressed: () => context.push(
                AppRoutes.fatigueSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.bedtime_outlined,
              label: 'Sono',
              onPressed: () => context.push(
                AppRoutes.sleepSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.healing,
              label: 'Inchaço',
              onPressed: () => context.push(
                AppRoutes.swellingSelectionPage,
              ),
            ),
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
              width: width * 0.5,
              elevation: 6,
            ),
            const Gap(16),
            FadeButton(
              label: 'Exercícios',
              onPressed: () {
                // Navigate to Exercícios page
              },
              width: width * 0.5,
              elevation: 6,
            ),
          ],
        ),
        const Gap(32),
        const QuestionCard(
          question: 'Você está se sentindo bem?',
        ),
      ],
    );
  }
}

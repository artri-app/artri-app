import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class UserDiaryInitialSelection extends StatelessWidget {
  const UserDiaryInitialSelection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = ScreenHelper.getScreenWidth(context);

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
              onPressed: () => context.go(
                UserDiaryRoutes.painSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.battery_alert_outlined,
              label: 'Fadiga',
              onPressed: () => context.go(
                UserDiaryRoutes.fatigueSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.bedtime_outlined,
              label: 'Sono',
              onPressed: () => context.go(
                UserDiaryRoutes.sleepSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.healing,
              label: 'Inchaço',
              onPressed: () => context.go(
                UserDiaryRoutes.swellingSelectionPage,
              ),
            ),
          ],
        ),
        const Gap(32),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomOutlinedButton(
              color: AppColors.darkGreen,
              text: 'MEDICAMENTOS',
              borderWidth: 2,
              onPressed: () => context.go(LoggedRoutes.remedy),
            ),
            const Gap(16),
            CustomOutlinedButton(
              color: AppColors.darkGreen,
              text: 'EXERCÍCIOS',
              borderWidth: 2,
              onPressed: () {
                // Navigate to Exercícios page
              },
              width: width * 0.5,
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

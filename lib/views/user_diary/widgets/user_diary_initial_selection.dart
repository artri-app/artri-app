import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/helpers/myths_helper.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDiaryInitialSelection extends StatelessWidget {
  final currentMyth = MythsHelper().getRandomMyth();

  @override
  Widget build(BuildContext context) {
    double width = ScreenHelper.getScreenWidth(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Olá, usuario!',
          style: GoogleFonts.montserrat(
            fontSize: 40,
            color: const Color(0xff026873),
          ),
        ),
        Text(
          'Como você está hoje?'.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        const Gap(40),
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
                UserDiaryRoutes.painSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.battery_alert_outlined,
              label: 'Fadiga',
              onPressed: () => context.push(
                UserDiaryRoutes.fatigueSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.bedtime_outlined,
              label: 'Sono',
              onPressed: () => context.push(
                UserDiaryRoutes.sleepSelectionPage,
              ),
            ),
            RoundedButton(
              color: const Color(0xFF026873),
              icon: Icons.healing,
              label: 'Inchaço',
              onPressed: () => context.push(
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
              onPressed: () => context.push(LoggedRoutes.remedy),
            ),
            const Gap(16),
            CustomOutlinedButton(
              color: AppColors.darkGreen,
              text: 'EXERCÍCIOS',
              borderWidth: 2,
              onPressed: () {
                // Navigate to Exercícios page
                // context.push(BottomNavRoutes.exercise);
              },
              width: width * 0.5,
            ),
          ],
        ),
        const Gap(32),
        // Mito Verdade Question
        MythTruthCard(
          myth: currentMyth,
        ),
      ],
    );
  }
}

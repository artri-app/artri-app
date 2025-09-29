import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDiaryPage extends StatelessWidget {
  final Widget child;
  const UserDiaryPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            child,
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () => context.push(
              AppRoutes.configuration,
            ),
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.darkGreen,
            ),
            iconSize: 42,
          ),
        ),
      ],
    );
  }
}

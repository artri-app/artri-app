import 'dart:math';

import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDiaryPage extends StatelessWidget {
  final Widget child;
  const UserDiaryPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final bool isSetting = location == UserDiaryRoutes.settings;
    final double screenWidth = ScreenHelper.getScreenWidth(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo-ArtriApp-v2.svg',
                  width: min(
                    180,
                    screenWidth * 0.50,
                  ),
                ),
                const Gap(24),
                Text(
                  'Olá!',
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
                const Gap(24),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () => context.go(
              isSetting ? BottomNavRoutes.diary : UserDiaryRoutes.settings,
            ),
            icon: Icon(
              isSetting ? Icons.settings : Icons.settings_outlined,
              color: AppColors.darkGreen,
            ),
            iconSize: 42,
          ),
        ),
      ],
    );
  }
}

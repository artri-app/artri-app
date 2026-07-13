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
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: AppColors.darkGreen,
                  child: Icon(Icons.person, color: Colors.white, size: 104),
                ),
                const Gap(24),
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
            onPressed: () => context.push(
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

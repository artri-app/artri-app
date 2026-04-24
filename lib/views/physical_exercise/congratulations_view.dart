import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CongratulationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenHelper.getScreenSize(context);

    return Scaffold(
      backgroundColor: AppColors.darkGreen,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            onPressed: () => context.canPop() ? context.pop() : context.go(''),
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
      body: Center(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/confetti.svg',
                width: screenSize.width * 1.5,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/medal.svg',
                    width: screenSize.width * 0.4,
                  ),
                  Text(
                    'Parabéns!',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Você concluiu mais uma série de execícios e está cuidando da sua saúde!',
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseButton extends StatelessWidget {
  final String buttonText;
  final Function onClick;
  final double? width;
  final ExerciseButtonSide side;
  final List<Color>? gradientColors;
  final Color? color;
  final double? fontSize;

  const ExerciseButton({
    super.key,
    required this.onClick,
    this.buttonText = 'Button',
    this.width,
    this.side = ExerciseButtonSide.right,
    this.gradientColors,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = ScreenHelper.getScreenSize(context);

    final bool isSmallScreen = screenSize.width < 700;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onClick(),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: width ??
                  (isSmallScreen
                      ? screenSize.width * 0.9
                      : screenSize.width * 0.5),

              constraints: const BoxConstraints(
                minHeight: 62,
              ),

              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 20,
              ),

              decoration: BoxDecoration(
                gradient: gradientColors != null
                    ? LinearGradient(colors: gradientColors!)
                    : null,
                color: color,
                borderRadius: BorderRadius.circular(200),
              ),

              child: Padding(
                padding: EdgeInsets.only(
                  left: side == ExerciseButtonSide.left ? 36 : 0,
                  right: side == ExerciseButtonSide.right ? 36 : 0,
                ),

                child: Center(
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    softWrap: true,

                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,

                      fontSize: fontSize ?? (isSmallScreen ? 22 : 28),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              right: side == ExerciseButtonSide.right ? -12 : null,
              left: side == ExerciseButtonSide.left ? -12 : null,
              child: Icon(
                Icons.play_circle_outline_outlined,
                size: isSmallScreen ? 64 : 84,
                color: AppColors.darkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
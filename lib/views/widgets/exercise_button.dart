import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseButton extends StatelessWidget {
  final String buttonText;
  final Function onClick;
  final double? width;
  final ExerciseButtonSide side;
  final List<Color>? gradientColors;
  final Color? color;

  const ExerciseButton({
    super.key,
    required this.onClick,
    this.buttonText = 'Button',
    this.width,
    this.side = ExerciseButtonSide.right,
    this.gradientColors,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onClick(),
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        alignment: AlignmentGeometry.center,
        children: [
          Container(
            width: width ?? screenSize.width * 0.5,
            height: 62,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              gradient: gradientColors != null
                  ? LinearGradient(
                      colors: gradientColors ?? [],
                    )
                  : null,
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Positioned(
            right: side == ExerciseButtonSide.right ? -12 : null,
            left: side == ExerciseButtonSide.left ? -12 : null,
            child: Icon(
              Icons.play_circle_outline_outlined,
              size: 84,
              color: AppColors.darkGreen,
            ),
          ),
        ],
      ),
    );
  }
}

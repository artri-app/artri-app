import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintIndicatorTooltip extends StatelessWidget {
  final String tooltipMessage;
  final String? tooltipTitle;

  const HintIndicatorTooltip({
    super.key,
    required this.tooltipMessage,
    this.tooltipTitle,
  });

  void showHint(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.lightBrown,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        title: tooltipTitle != null
            ? Text(
                tooltipTitle!,
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  height: 1.25,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        content: SingleChildScrollView(
          child: Text(
            tooltipMessage,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              height: 1.4,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Entendi',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: AppColors.darkGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: IconButton.outlined(
        padding: EdgeInsets.zero,
        iconSize: 18,
        tooltip: tooltipTitle ?? 'Ver explicação',
        color: AppColors.darkGreen,
        onPressed: () => showHint(context),
        icon: const Icon(Icons.question_mark),
      ),
    );
  }
}

import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HintIndicatorTooltip extends StatelessWidget {
  final String tooltipMessage;

  const HintIndicatorTooltip({
    super.key,
    required this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Tooltip(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      message: tooltipMessage,
      enableTapToDismiss: true,
      constraints: BoxConstraints(maxWidth: 0.8 * width),
      decoration: BoxDecoration(
        color: AppColors.lightBrown,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
      child: Container(
        width: 24,
        height: 24,
        child: IconButton.outlined(
          padding: EdgeInsets.all(0),
          iconSize: 16,
          icon: Icon(
            Icons.question_mark,
          ),
          color: AppColors.darkGreen,
          onPressed: () => {},
        ),
      ),
    );
  }
}

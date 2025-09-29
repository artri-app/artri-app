import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

class ConfirmationButtons extends StatelessWidget {
  final ValueChanged<ConfirmationAction> onButtonClicked;

  const ConfirmationButtons({super.key, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: 'Cancelar',
          onPressed: () => onButtonClicked.call(ConfirmationAction.canceled),
          gradientColors: AppGradients.redGradient,
        ),
        CustomButton(
          text: 'Salvar',
          onPressed: () => onButtonClicked.call(ConfirmationAction.confirmed),
          gradientColors: AppGradients.greenGradient,
        ),
      ],
    );
  }
}
